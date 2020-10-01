import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/util/map_util.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/api/map_search_service.dart';
import 'package:melton_app/util/model_util.dart';
import 'package:melton_app/util/text_util.dart';
import 'package:melton_app/screens/components/user_details_dialog.dart';


class FellowsMap extends StatefulWidget {
  @override
  _FellowsMapState createState() => _FellowsMapState();
}

class _FellowsMapState extends State<FellowsMap> {
  Completer<GoogleMapController> _controller = Completer();


  final LatLng _center = MapUtil.getLatLngForRandomMeltonCity();
  List<UserModel> allUsers;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool showMapMarkers = true;
  bool showFellowInfoBox = false;
  UserModel selectedUser;

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    _setMapStyle();
    allUsers = await MapSearchService().usersStream.first;
    Map<MarkerId, Marker> userMarkers = Map.fromIterable(
        allUsers, key: (user) => MarkerId(user.id.toString()),
        value: (user) => Marker(
          markerId: MarkerId(user.id.toString()),
          //todo "not_found" needed?
          position: MapUtil.getLatLngForCityWithRandomization(validateCity(user.city, user.country) ?? "NOT_FOUND"),
          infoWindow: InfoWindow(
            title: user.name,
            snippet: validateCity(user.city, user.country)
          ),
          onTap: () {
            setState(() {
              showFellowInfoBox = true;
              selectedUser = user;
            });
          },
        ));
    if (showMapMarkers) {
      setState(() {
        markers = userMarkers;
      });
    }
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString(MapUtil.MAP_STYLE_PATH);
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(style);
  }

  Future<void> _goToRandomMeltonCity() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_getCameraPositionForRandomMeltonCity()));
  }

  CameraPosition _getCameraPositionForRandomMeltonCity() {
    return CameraPosition(
      target: MapUtil.getLatLngForRandomMeltonCity(),
      zoom: 11.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Fellows Map"),
      backgroundColor: Constants.meltonBlue,
      ),
      body: Stack(
        children: [
          GoogleMap(
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition:
          CameraPosition(
            target: _center,
            zoom: 11.0,
            ),
          markers: Set<Marker>.of(markers.values),
          ),
          showFellowInfoBox ? _getFellowInfoBox(selectedUser) : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shuffle),
        onPressed: () {
          _goToRandomMeltonCity();
        },
      ),
    );
  }

  Widget _getFellowInfoBox(UserModel selectedUser) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 100),
          height: 90,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 20,
                    offset: Offset.zero,
                    color: Colors.grey.withOpacity(0.5)
                )]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 20.0),
              isStringSpecified(selectedUser?.picture) ?
              CircleAvatar(
                backgroundImage: NetworkImage(selectedUser.picture),
              ) : CircleAvatar(
                  backgroundImage: AssetImage(Constants.placeholder_avatar)
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectedUser.name.length > 20 ?
                    BlackSubtitleText(content: selectedUser.name) :
                    BlackTitleText(content: selectedUser.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlackSubtitleText(content: selectedUser.campus),
                      BlackSubtitleText(content: "  "),
                      BlackSubtitleText(content: selectedUser.batch.toString()),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => UserDetails(id: selectedUser.id, userName: selectedUser.name)));
                },
                color: Constants.meltonRed,
                iconSize: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
