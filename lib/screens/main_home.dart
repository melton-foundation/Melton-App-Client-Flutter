import 'package:flutter/material.dart';

import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/screens/about.dart';

import 'package:melton_app/screens/login.dart';
import 'package:melton_app/screens/profile.dart';
import 'package:melton_app/screens/directory.dart';
import 'package:melton_app/screens/home.dart';
import 'package:melton_app/screens/authorization_wall.dart';
import 'package:mailto/mailto.dart';
import 'package:melton_app/util/url_launch_util.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  final String title = "Melton Foundation";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentScreenIndex = 1;

  final screens = [
    Directory(),
    Home(),
    Profile(),
    LoginScreen(),
    AuthorizationWall()
  ];

  final supportMailto = Mailto(
    to: ["meltonapp.mf@gmail.com"],
    cc: ["bijapurpranav@gmail.com", "larsd.mf@gmail.com"],
    subject: "Melton App: quick question",
    body: "Hey there! ",
  );

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
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleChoice,
            icon: Icon(
              Icons.more_vert,
              color: Constants.meltonRedYellowGreen[_currentScreenIndex],
            ),
            itemBuilder: (BuildContext context) {
              return <String>[Constants.APPBAR_ABOUT, Constants.APPBAR_HELP, Constants.APPBAR_PRIVACY_POLICY].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
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

  void handleChoice(String choice) async {
    switch (choice) {
      case Constants.APPBAR_ABOUT:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => About()),
        );
        break;
      case Constants.APPBAR_HELP:
        await launchUrl("$supportMailto"); //todo ios test on real device
        break;
      case Constants.APPBAR_PRIVACY_POLICY:
        await launchUrl(Constants.MELTON_PRIVACY_POLICY_URL);
        break;
    }
  }
}
