import 'package:flutter/material.dart';
import 'package:melton_app/screens/profile_edit.dart';
import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/constants/constants.dart' as Constants;
import 'package:melton_app/screens/components/profile_line_item.dart';
import 'package:melton_app/screens/sdg_profile.dart';

import 'package:melton_app/screens/components/JF_badge.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<ProfileModel> _model = ApiService().getProfile();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: FutureBuilder<ProfileModel>(
          future: _model,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  //todo pull to refresh
                  children: [
                    SizedBox(height: 10.0),
                    Center(child:
                      Card(
                        elevation: 18.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundImage: snapshot.data.picture == null ?
                            AssetImage(Constants.placeholder_avatar) :
                            NetworkImage(snapshot.data.picture), radius: 50.0,
                        ),
                      ),
                    ),
                    snapshot.data.name == null ? ProfileLineItem(label: "NAME", content: "----") : ProfileLineItem(label: "", content: snapshot.data.name.toUpperCase()),
                    Center(child: JFBadge(isJF: snapshot.data.isJuniorFellow)),
                    //todo add social media icons
                    snapshot.data.work == null ? Container() : ProfileLineItem(label: "WORK", content: snapshot.data.work),
                    snapshot.data.SDGs == null ? Container() : SDGProfile(
                      firstSDG: snapshot.data.SDGs.firstSDG,
                      secondSDG: snapshot.data.SDGs.secondSDG,
                      thirdSDG: snapshot.data.SDGs.thirdSDG,
                    ),
                    snapshot.data.campus == null ? Container() : ProfileLineItem(label: "CAMPUS", content: snapshot.data.campus),
                    snapshot.data.batch == null ? Container() : ProfileLineItem(label: "BATCH", content: snapshot.data.batch.toString()),
                    snapshot.data.city == null ? Container() : ProfileLineItem(label: "CITY", content: snapshot.data.city),
                    snapshot.data.email == null ? Container() : ProfileLineItem(label: "EMAIL", content: snapshot.data.email),


                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}"); //todo handle correctly
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ProfileEdit()));
            },
        )
      );
  }
}
