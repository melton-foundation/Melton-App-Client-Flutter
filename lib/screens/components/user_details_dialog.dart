import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/screens/components/JF_badge.dart';
import 'package:melton_app/screens/components/profile_line_item.dart';
import 'package:melton_app/screens/components/profile_photo.dart';

class UserDetails extends StatelessWidget {
  final Widget empty = Container(width: 0.0, height: 0.0);
  final Future<UserModel> _userModel;

  UserDetails(this._userModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:Text("User Details")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<UserModel>(
          future: _userModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:Column(
                  children: [
                    ProfilePhoto(url: snapshot.data.picture),
                    ProfileLineItem(
                        label: "", content: snapshot.data.name.toUpperCase()),
                    Center(child: JFBadge(isJF: snapshot.data.isJuniorFellow)),
                    /*(snapshot.data.work == null ||
                        snapshot.data.work.length == 0)
                        ? empty
                        : ProfileLineItem(
                        label: "WORK", content: snapshot.data.work),
                    snapshot.data.SDGs == null
                        ? empty
                        : SDGProfile(
                      firstSDG: snapshot.data.SDGs.firstSDG,
                      secondSDG: snapshot.data.SDGs.secondSDG,
                      thirdSDG: snapshot.data.SDGs.thirdSDG,
                    ),*/
                    ProfileLineItem(
                        label: "CAMPUS",
                        content: snapshot.data.campus.toUpperCase()),
                    ProfileLineItem(
                        label: "BATCH",
                        content: snapshot.data.batch.toString()),
                    (snapshot.data.city == null ||
                        snapshot.data.city.length == 0)
                        ? empty
                        : ProfileLineItem(
                        label: "CITY", content: snapshot.data.city),
                    //todo convert to mailto:url
                    ProfileLineItem(
                        label: "EMAIL", content: snapshot.data.email == null?"NA":snapshot.data.email),
                  ],
                ),

                //Text(snapshot.data.name),
              );
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}"); //todo handle correctly
            }
            //todo make fun error screen
            return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
          },
        ),
      ),
    );
    /*AlertDialog(
      title: Text('User Profile'),
      content: ,
    );*/
  }
}

