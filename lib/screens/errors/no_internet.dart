import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/errors/error_no_internet.png"),
            Text("NO INTERNET", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),),
            Text(""),
            Text("Or our server is down...", style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
