import 'package:flutter/material.dart';
import 'package:melton_app/screens/profile_edit.dart';
import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/constants/constants.dart' as Constants;

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
                    SizedBox(height: 20.0),
                    Center(child:
                      CircleAvatar(
                        backgroundImage: snapshot.data.picture == null ?
                          AssetImage(Constants.placeholder_avatar) :
                          NetworkImage(snapshot.data.picture), radius: 50.0,),
                    ),
                    Divider(color: Constants.meltonBlue,),
                    Text("NAME",
                      textAlign: TextAlign.left,
                      style: TextStyle(letterSpacing: 2.0,
                          color: Constants.meltonBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Constants.meltonRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Divider(color: Constants.meltonBlue,),
                    Text("CAMPUS",
                      textAlign: TextAlign.left,
                      style: TextStyle(letterSpacing: 2.0,
                          color: Constants.meltonBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data.campus,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Constants.meltonRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
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
