import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;

class ProfileEdit extends StatelessWidget {
  bool isPhoneValid = false; // use validator or make this stateful

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)), // todo fix side padding
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
              icon: Icon(Icons.account_box), //todo account_box??
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Campus", //todo - make dropdown?
              icon: Icon(Icons.home),
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Work info",
              icon: Icon(Icons.business_center),
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Phone number",
              errorText: isPhoneValid ? null : "'+CC XXXXXXXXXX' where 'CC' is your country code.",
              icon: Icon(Icons.phone),
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
//          DropdownButton(
//            items: Constants.campuses.map((c) => DropdownMenuItem(child:Text(c),)).toList(), //todo anything else needed?
//            items: [DropdownMenuItem(child:Text(Constants.campuses[0]), value: 1,)],
//          ),


          //todo remaining dropdowns and fields

          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text("UPDATE MY PROFILE", style: TextStyle(color: Colors.white),),
            onPressed: () {
              //todo POST api call
              // todo based on true/false, show toast notification?
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }
}
