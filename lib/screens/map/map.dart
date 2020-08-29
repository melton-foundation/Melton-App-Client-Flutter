import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;

void main() {
  runApp(map());
}

double lat = 12.9791198;
double lng = 77.5612997;

class map extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// Map<String, dynamic> map = jsonDecode(
//     'https://nominatim.openstreetmap.org/?q=Bangalore&format=json&limit=1');
// double lat = map['lat'];
// double lng = map['lon'];

class _MyAppState extends State<map> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final MelLoc = await locations.meltonpeeps();
    setState(() {
      _markers.clear();
      for (final office in MelLoc.offices) {
        final marker = Marker(
          markerId: MarkerId(office.country),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.country,
          ),
        );
        lat++;
        lng++;
        _markers[office.country] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //appBar: AppBar(
        //title: const Text('Melton Foundation'),
        //   backgroundColor: Colors.green[700],
        //  ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(0, 0),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
