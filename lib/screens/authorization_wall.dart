import 'package:flutter/material.dart';

import 'package:melton_app/constants/constants.dart' as Constants;

class AuthorizationWall extends StatefulWidget {
  @override
  _AuthorizationWallState createState() => _AuthorizationWallState();
}

class _AuthorizationWallState extends State<AuthorizationWall> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 150,),
          Image.asset("assets/splash.png"),
          FormTitle("OOPS!"),
          FormSubtitle("Your email wasn't saved in a Melton database."),
          FormSubtitle("We will verify and approve you."),
          FormSubtitle("Try signing in again later :)"),
          Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
          RaisedButton(
              child: Text("CLOSE", style: TextStyle(color: Colors.white),),
              color: Constants.meltonRedAccent,
              onPressed: () {
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  final String text;

  FormTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Constants.meltonBlue,
        fontWeight: FontWeight.bold, fontSize: 18),);
  }
}

class FormSubtitle extends StatelessWidget {
  final String text;

  FormSubtitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Constants.meltonBlue, fontSize: 14),);
  }
}
