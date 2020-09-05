import 'package:flutter/material.dart';

import 'package:melton_app/screens/profile_edit.dart';
import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/api/api.dart';

import 'package:melton_app/screens/components/store_line_item.dart';
import 'package:melton_app/screens/components/profile_line_item.dart';
import 'package:melton_app/screens/components/sdg_profile.dart';
import 'package:melton_app/screens/components/JF_badge.dart';
import 'package:melton_app/screens/components/social_media_line_item.dart';
import 'package:melton_app/screens/components/profile_photo.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<ProfileModel> _model = ApiService().getProfile();
  ProfileModel _loaded;
  bool isProfileUpdated = false; //todo rebuild page if true

  final Widget empty = Container(width: 0.0, height: 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<ProfileModel>(
          future: _model,
          builder: (context, snapshot) {
            //todo use connection state != done
            // todo also add connection.none for "no internet" error in all futures
            if (snapshot.hasData) {
              _loaded = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                //todo implement pull to refresh
                child: RefreshIndicator(
                  onRefresh: () {print("REFRESH");},
                  child: ListView(
                    children: [
                      SizedBox(height: 10.0),
                      ProfilePhoto(url: snapshot.data.picture),
                      ProfileLineItem(
                          label: "", content: snapshot.data.name.toUpperCase()),
                      Center(child: JFBadge(isJF: snapshot.data.isJuniorFellow)),
                      snapshot.data.points == null
                          ? empty
                          : StoreLineItem(
                              points: snapshot.data.points,
                            ),
                      SocialMediaLineItem(
                        facebook: snapshot.data.socialMediaAccounts.facebook,
                        instagram: snapshot.data.socialMediaAccounts.instagram,
                        twitter: snapshot.data.socialMediaAccounts.twitter,
                        wechat: snapshot.data.socialMediaAccounts.wechat,
                        linkedin: snapshot.data.socialMediaAccounts.linkedin,
                        others: snapshot.data.socialMediaAccounts.others,
                      ),
                      //todo rename "work" to "bio"??
                      (snapshot.data.work == null ||
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
                            ),
                      //todo convert to tel:
                      ProfileLineItem(
                        label: "PHONE",
                        content: "+" + snapshot.data.phoneNumber.countryCode +
                            " " + snapshot.data.phoneNumber.phoneNumber,
                      ),
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
                          label: "EMAIL", content: snapshot.data.email),
                    ],
                  ),
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
                .push(MaterialPageRoute(builder: (_) => ProfileEdit(initialModel: _loaded)));
            if (isProfileUpdated != null && isProfileUpdated) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved profile."),));
              await Future.delayed(Duration(seconds: 2));
              setState(() {}); //todo test if this rebuilds the page
            }
          },
        )
    );
  }
}
