import 'package:flutter/material.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/ProfileModel.dart';

class ProfileSave extends StatefulWidget {
  final ProfileModel profileModel;

  ProfileSave({this.profileModel});

  @override
  _ProfileSaveState createState() => _ProfileSaveState();
}

class _ProfileSaveState extends State<ProfileSave> {
  Future<bool> _response;

  @override
  Widget build(BuildContext context) {
    _response = ApiService().postProfile(widget.profileModel);
    return FutureBuilder<bool>(
        future: _response,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
//              color: Colors.white,
                body: Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator())
                )
            );
          }
          if (snapshot.hasData) {
            Future.delayed(Duration(seconds: 2));
            Navigator.pop(context, true);
          }
          if (snapshot.hasError) {
            Navigator.pop(context, false);
          }
          return Container();
        }
    );
  }
}
