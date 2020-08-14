import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
//    return Container();
      return Scaffold(
        body: Text("PROFILE"),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: null),
      );
  }
}
