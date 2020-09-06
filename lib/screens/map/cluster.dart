import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(cluster());

class cluster extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cluster Manager Demo',
      home: MapSample(),
    );
  }
}

//Their own class
class Place {
  final String name;
  final bool isClosed;

  const Place({this.name, this.isClosed = false});

  @override
  String toString() {
    // TODO: implement toString
    return 'Place $name (closed : $isClosed)';
  }
}

//the class I made to extract info.
class Tag {
  double lat;
  double lng;

  Tag(this.lat, this.lng);

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(json['lat'] as double, json['lng'] as double);
  }
}

Future<String> _loadAStudentAsset() async {
  return await rootBundle.loadString('assets/student.json');
}

Future<Tag> loadStudent() async {
  String jsonString = await _loadAStudentAsset();
  final jsonResponse = json.decode(jsonString);
  return new Tag.fromJson(jsonResponse);
}

// A function that converts a response body into a List<Tag>.
List<Tag> parseTAG(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Tag>((json) => Tag.fromJson(json)).toList();
}

Future<List<Tag>> fetchTAG(http.Client client) async {
  final response =
      await client.get('https://arunjoseph19.github.io/leaf/short.json');

  return parseTAG(response.body);
}

// Clustering maps
class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  ClusterManager _manager;

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = Set();

  final CameraPosition _parisCameraPosition =
      CameraPosition(target: LatLng(48.856613, 2.352222));

  // Future<void> locgen() async {
  //   final MelLoc = await locations.meltonpeeps();
  //   items = [
  //     for (final office in MelLoc.offices)
  //       ClusterItem(LatLng(office.lat, office.lng)),
  //   ];
  // }

//So here instead of lat, lng.
//We have to put the ones we got from above.
//I'm stuck at this part.
  List<ClusterItem<Place>> items = [
    for (int i = 0; i < 7; i++)
      ClusterItem(LatLng(5.55 + i * 0.001, -0.2167 + i * 0.001),
          item: Place(name: 'Ashesi Ghana $i')),
    for (int i = 0; i < 8; i++)
      ClusterItem(LatLng(12.97 - i * 0.001, 77.56 + i * 0.001),
          item: Place(name: 'BMS Bangalore $i')),
    for (int i = 0; i < 4; i++)
      ClusterItem(LatLng(30.0687 + i * 0.01, -89.9288 - i * 0.01),
          item: Place(name: 'Dillard New Orleans $i')),
    for (int i = 0; i < 2; i++)
      ClusterItem(LatLng(50.9304 - i * 0.1, 11.58 - i * 0.01),
          item: Place(name: 'FSU Jena $i')),
    for (int i = 0; i < 5; i++)
      ClusterItem(LatLng(-38.73 - i * 0.1, -72.58 - i * 0.01),
          item: Place(name: 'UFFRO Chile $i')),
    for (int i = 0; i < 5; i++)
      ClusterItem(LatLng(24.5204 - i * 0.1, 117.67 - i * 0.01),
          item: Place(name: 'Zhejiang Hangzhou $i')),
  ];

  @override
  void initState() {
    _manager = _initClusterManager();
    super.initState();
    //fetchTAG(http.Client());
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<Place>(items, _updateMarkers,
        markerBuilder: _markerBuilder, initialZoom: _parisCameraPosition.zoom);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _parisCameraPosition,
          markers: markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _manager.setMapController(controller);
          },
          onCameraMove: _manager.onCameraMove,
          onCameraIdle: _manager.updateMap),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _manager.setItems(<ClusterItem<Place>>[
      //       for (int i = 0; i < 30; i++)
      //         ClusterItem<Place>(LatLng(48.858265 + i * 0.01, 2.350107),
      //             item: Place(name: 'New Place ${DateTime.now()}'))
      //     ]);
      //   },
      //   child: Icon(Icons.update),
      // ),
    );
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String text}) async {
    assert(size != null);

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}
