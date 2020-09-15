import 'dart:async';

import 'package:flutter/material.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/screens/components/UserProfileInformation.dart';
import 'package:melton_app/screens/profile_edit.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  StreamController<ProfileModel> _streamController;
  ProfileModel _loaded;
  bool isProfileUpdated = false;

  final Widget empty = Container(width: 0.0, height: 0.0);

  @override
  void initState() {
    _streamController = StreamController<ProfileModel>();
    loadProfile();
    super.initState();
  }

  loadProfile() async {
    ApiService().getProfile().then((res) async {
      _streamController.add(res);
    });
  }

  Future<void> _handleRefresh() async {
    await loadProfile();
    await Future.delayed(Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Refreshed profile!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<ProfileModel>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            //todo use connection state != done
            // todo also add connection.none for "no internet" error in all futures
            if (snapshot.hasData) {
              _loaded = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: buildUserDetailsListView(snapshot.data),
                ),
              );
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}"); //todo handle correctly
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () async {
            _loaded == null ? null :
            isProfileUpdated = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ProfileEdit(initialModel: _loaded, profileRefreshFunction: loadProfile)));
            if (isProfileUpdated != null && isProfileUpdated) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Saved profile."),
              ));
              loadProfile();
            }
          },
        )
    );
  }

  ListView buildUserDetailsListView(ProfileModel data) {
    return ListView(
      children: getUserDetails(
        isProfileModel: true,
        picture: data.picture,
        name: data.name,
        isJuniorFellow: data.isJuniorFellow,
        points: data.points,
        socialMediaAccounts: data.socialMediaAccounts,
        work: data.work,
        SDGs: data.SDGs,
        phoneNumber: data.phoneNumber.phoneNumber,
        countryCode: data.phoneNumber.countryCode,
        campus: data.campus,
        batch: data.batch,
        city: data.city,
        email: data.email,
      ),
    );
  }
}
