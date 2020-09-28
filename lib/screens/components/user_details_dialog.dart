import 'package:flutter/material.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/screens/components/UserProfileInformation.dart';
import 'package:melton_app/util/model_util.dart';

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
              return buildUserDetailsSingleChildScrollView(snapshot.data);
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

  SingleChildScrollView buildUserDetailsSingleChildScrollView(UserModel data) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: getUserDetails(
          isProfileModel: false,
          picture: data.picture,
          name: data.name,
          isJuniorFellow: data.isJuniorFellow,
          socialMediaAccounts: data.socialMediaAccounts,
          bio: data.bio,
          work: data.work,
          SDGs: data.SDGs,
          phoneNumber: data.phoneNumber.phoneNumber,
          countryCode: data.phoneNumber.countryCode,
          campus: data.campus,
          batch: data.batch,
          city: validateCity(data.city, data.country),
          email: data.email,
        ),
      ),
    );
  }
}
