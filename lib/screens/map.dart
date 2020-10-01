import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/util/map_util.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;

  final LatLng _center = MapUtil.getLatLngForRandomMeltonCity();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    //todo add markers
    _setMapStyle();
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString(MapUtil.MAP_STYLE_PATH);
    mapController.setMapStyle(style);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Fellows Map"),
      backgroundColor: Constants.meltonBlue,
      ),
      body: GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition:
      CameraPosition(
        target: _center,
        zoom: 11.0,
        ),
      ),
    );
  }
}
