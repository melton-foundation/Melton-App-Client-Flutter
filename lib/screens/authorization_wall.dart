import 'package:flutter/material.dart';

import 'package:melton_app/constants/constants.dart';

class AuthorizationWall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/errors/error_user_not_found.png"),
              FormTitle("WHO ARE YOU?"),
              FormSubtitle("Your email wasn't saved in a Melton database."),
              FormSubtitle(
                  "We will verify that you're a Melton Fellow, and approve you."),
              FormSubtitle(
                  "Try using another email, or signing in again later :)"),
              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              RaisedButton(
                  child: Text(
                    "CLOSE",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Constants.meltonRedAccent,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  final String text;

  FormTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Constants.meltonBlue,
          fontWeight: FontWeight.bold,
          fontSize: 18),
    );
  }
}

class FormSubtitle extends StatelessWidget {
  final String text;

  FormSubtitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Constants.meltonBlue, fontSize: 14),
    );
  }
}
