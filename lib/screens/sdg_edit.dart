import 'package:flutter/material.dart';

class SDGGridItem extends StatefulWidget {
  @override
  _SDGGridItemState createState() => _SDGGridItemState();
}

// todo use image grid view?
class _SDGGridItemState extends State<SDGGridItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select up to 3 SDGs")),
//      body: ,https://medium.com/flutterdevs/selecting-multiple-item-in-list-in-flutter-811a3049c56f
    );
  }
}
