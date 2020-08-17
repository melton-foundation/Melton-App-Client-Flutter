import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;

class ProfileLineItem extends StatelessWidget {
  final String label;
  final String content;

  ProfileLineItem({this.label, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(),
        Text(label,
        textAlign: TextAlign.left,
        style: TextStyle(letterSpacing: 2.0,
        color: Constants.meltonBlue,
        fontWeight: FontWeight.bold),
        ),
        Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Constants.meltonRed,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
