import 'package:flutter/material.dart';
import 'package:melton_app/screens/posts/posts_preview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
//        Column(
//          children: [
            PostsPreview(),
            //todo other "home" components
            // maps api? other stuff?
//          ],
//        ),
      ),
    );
  }
}
