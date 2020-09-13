import 'package:flutter/material.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/screens/components/JF_badge.dart';
import 'package:melton_app/screens/components/UserProfileInformation.dart';
import 'package:melton_app/screens/components/profile_photo.dart';

class UserDetails extends StatelessWidget {
  final String userName;
  final Widget empty = Container(width: 0.0, height: 0.0);
  final id;

  UserDetails({@required this.id, @required this.userName});

  @override
  Widget build(BuildContext context) {
    Future<UserModel> _userModel =
        ApiService().getUserModelById(id); // TODO: add error case here
    return Scaffold(
      appBar: AppBar(title: Text(userName)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<UserModel>(
          future: _userModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return buildUserDetailsSingleChildScrollView(snapshot);
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
  }

  SingleChildScrollView buildUserDetailsSingleChildScrollView(
      AsyncSnapshot<UserModel> snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(height: 10.0),
          ProfilePhoto(url: snapshot.data.picture),
          getProfileLineItemIfNotNull("", snapshot.data.name.toUpperCase()),
          Center(child: JFBadge(isJF: snapshot.data.isJuniorFellow)),
          getUserSocialMediaDetails(snapshot.data.socialMediaAccounts),
          getProfileLineItemIfNotNullAndEmpty("WORK", snapshot.data.work),
          getUsersSDGInfo(snapshot.data.SDGs),
          //todo convert to tel:
          getUserPhoneNumberDetails(snapshot.data.phoneNumber.phoneNumber,
              snapshot.data.phoneNumber.countryCode),
          getProfileLineItem("CAMPUS", snapshot.data.campus.toUpperCase()),
          getProfileLineItem("BATCH", snapshot.data.batch.toString()),
          getProfileLineItemIfNotNullAndEmpty("CITY", snapshot.data.city),
          //todo convert to mailto:url
          getProfileLineItem("EMAIL", snapshot.data.email),
        ],
      ),
    );
  }
}
