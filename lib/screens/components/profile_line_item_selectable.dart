import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:melton_app/constants/constants.dart';

class ProfileLineItemSelectable extends StatelessWidget {
  final String label;
  final String content;

  ProfileLineItemSelectable({this.label, this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(),
          Text(label,
            textAlign: TextAlign.left,
            style: TextStyle(letterSpacing: 2.0,
                color: Constants.meltonBlue,
                fontWeight: FontWeight.bold),
          ),
          FlatButton(
            onPressed: () {_launch(content, label == "PHONE");},
            child: SelectableText(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.meltonRed,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//todo test on android and ios
_launch(String url, bool isTel) async {
  if (isTel) {
    url = "tel://+" + url;
  } else {
    //isEmail
    url = "mailto:" + url + "?subject=Hey! I found you on the MF App";
  }
  print("trying " + url);
  if (await canLaunch(url)) {
    launch(url);
  } else {
    //todo handle nicely
    print("could not launch");
  }
}
