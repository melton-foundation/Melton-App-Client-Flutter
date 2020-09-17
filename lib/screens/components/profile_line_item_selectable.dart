import 'package:flutter/material.dart';

import 'package:melton_app/util/url_launch_util.dart';
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
            onPressed: () {launchTelOrMailtoUrl(content, label == "PHONE");},
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


