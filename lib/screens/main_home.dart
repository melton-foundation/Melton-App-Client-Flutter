import 'package:flutter/material.dart';

import 'package:melton_app/constants/constants.dart';

import 'package:melton_app/screens/login.dart';
import 'package:melton_app/screens/profile.dart';
import 'package:melton_app/screens/directory.dart';
import 'package:melton_app/screens/home.dart';
import 'package:melton_app/screens/authorization_wall.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  final String title = "Melton Foundation";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentScreenIndex = 2;

  final screens = [
    Directory(),
    Home(),
    Profile(),
    LoginScreen(),
    AuthorizationWall()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/icon.png", height: 40.0, width: 40.0),
            SizedBox(width: 20.0),
            Text(widget.title, style: TextStyle(
              color: Constants.meltonRedYellowGreen[_currentScreenIndex],
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreenIndex,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Constants.meltonBlue,
        items: [
          BottomNavigationBarItem(
            title: Text("Directory", style: TextStyle(color: Constants.meltonBlue,
                fontWeight: FontWeight.bold, fontSize: 16.0)),
            icon: Icon(Icons.contacts, color: Constants.meltonBlue),
            backgroundColor: Constants.meltonRedAccent,
          ),
          BottomNavigationBarItem(
            title: Text("Home", style: TextStyle(color: Constants.meltonBlue,
                fontWeight: FontWeight.bold, fontSize: 16.0)),
            icon: Icon(Icons.home, color: Constants.meltonBlue),
            backgroundColor: Constants.meltonYellowAccent,
          ),
          BottomNavigationBarItem(
            title: Text("Profile", style: TextStyle(color: Constants.meltonBlue,
                fontWeight: FontWeight.bold, fontSize: 16.0)),
            icon:  Icon(Icons.person, color: Constants.meltonBlue),
            backgroundColor: Constants.meltonGreenAccent,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentScreenIndex = index;
          });
        },
      ),
      body: screens[_currentScreenIndex],
    );
  }
}