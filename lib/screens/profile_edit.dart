import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:melton_app/models/ProfileModel.dart';

import 'package:melton_app/constants/constants.dart';

class ProfileEdit extends StatefulWidget {
//  final ProfileModel currentModel;
//  const ProfileEdit({this.currentModel});

  @override
  _ProfileEditState createState() => _ProfileEditState();
//  _ProfileEditState createState() => _ProfileEditState(latestModel: currentModel);
}

class _ProfileEditState extends State<ProfileEdit> {
//  ProfileModel latestModel;

//  _ProfileEditState({this.latestModel});

  bool isPhoneValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              maxLength: 40,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
                icon: Icon(Icons.account_box),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
            TextField(
              maxLength: 5, //todo make dropdown
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Campus", //todo - make dropdown?
                icon: Icon(Icons.home),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
            IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: () { showDatePicker(context: context,
                initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime(2050),
                helpText: "Which year did you join the foundation?", initialDatePickerMode: DatePickerMode.year); },),
            Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
            TextField(
              maxLines: 3,
              maxLength: 200,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Work info",
                icon: Icon(Icons.business_center),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
            TextField(
              maxLength: 30,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("\\+[0-9]{1,3}\s+[0-9]{5,15}"))], //todo fix
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone number",
                errorText: isPhoneValid ? null : "'+CC XXXXXXXXXX', 'CC' is country code.",
                icon: Icon(Icons.phone),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
//          DropdownButton(
//            items: Constants.campuses.map((c) => DropdownMenuItem(child:Text(c),)).toList(), //todo anything else needed?
//            items: [DropdownMenuItem(child:Text(Constants.campuses[0]), value: 1,)],
//          ),

          // todo - social media either dropdown or indicate which icons have first-class support??
            // todo - implicitly convert "weixin" to wechat?

            //todo remaining dropdowns and fields

            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("UPDATE MY PROFILE", style: TextStyle(color: Colors.white),),
              onPressed: () {
                //todo POST api call
                // todo based on true/false, show toast notification/snackbar?
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isPhoneNumberFormatted(String str) {
    if (phoneNumberRegex.hasMatch(str)) {
      return true;
    }
    return false;
  }
}
