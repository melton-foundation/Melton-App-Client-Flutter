import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;

class ProfileEdit extends StatelessWidget {
  bool isPhoneValid = false; // use validator or make this stateful

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
                icon: Icon(Icons.account_box), //todo account_box??
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone number",
                errorText: isPhoneValid ? null : "'+CC XXXXXXXXXX' where 'CC' is country code.",
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
      ),
    );
  }
}
