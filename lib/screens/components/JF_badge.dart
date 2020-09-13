import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart';

class JFBadge extends StatelessWidget {
  final bool isJF;

  JFBadge({this.isJF});

  @override
  Widget build(BuildContext context) {
    return isJF ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Text("  JUNIOR FELLOW  ",
          style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.white),),
        decoration: BoxDecoration(
          color: Constants.meltonYellowAccent,
          boxShadow: [BoxShadow(blurRadius: 1.0)],
          gradient: LinearGradient(colors: [Constants.meltonBlueAccent, Constants.meltonRedAccent]),
        ),
      ),
    ) : Container();
  }
}
