// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:convert';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Future _future;

//   Future<String> loadString() async =>
//       await rootBundle.loadString('assets/data.json');

//   List allMarkers = [];
//   GoogleMapController _controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _future = loadString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Stack(children: <Widget>[
//             FutureBuilder(
//               future: _future,
//               builder: (context, AsyncSnapshot snapshot) {
//                 List<dynamic> parsedJson = jsonDecode(snapshot.data);
//                 allMarkers = parsedJson.map((element) {
//                   return Marker(
//                       markerId: MarkerId(element['id']),
//                       position: LatLng(element['x'], element['y']));
//                 }).toList();
//               },
//             ),
//             GoogleMap(
//               initialCameraPosition:
//                   CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 1.0),
//               markers: Set.from(allMarkers),
//               onMapCreated: mapCreated,
//             ),
//           ]),
//         ),
//       ]),
//     );
//   }

//   void mapCreated(controller) {
//     setState(() {
//       _controller = controller;
//     });
//   }
// }
