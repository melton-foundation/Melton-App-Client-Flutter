import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';

import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/screens/about.dart';

import 'package:melton_app/screens/login.dart';
import 'package:melton_app/screens/profile.dart';
import 'package:melton_app/screens/directory.dart';
import 'package:melton_app/screens/home.dart';
import 'package:melton_app/screens/authorization_wall.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new Menudot());

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  final String title = "Melton Foundation";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Menudot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/icon.png", height: 40.0, width: 40.0),
            SizedBox(width: 20.0),
            Text(
              widget.title,
              style: TextStyle(
                color: Constants.meltonRedYellowGreen[_currentScreenIndex],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            icon: Icon(
              Icons.more_vert,
              color: Constants.meltonRedYellowGreen[_currentScreenIndex],
            ),
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreenIndex,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Constants.meltonBlue,
        items: [
          BottomNavigationBarItem(
            title: Text("Directory",
                style: TextStyle(
                    color: Constants.meltonBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
            icon: Icon(Icons.contacts, color: Constants.meltonBlue),
            backgroundColor: Constants.meltonRedAccent,
          ),
          BottomNavigationBarItem(
            title: Text("Home",
                style: TextStyle(
                    color: Constants.meltonBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
            icon: Icon(Icons.home, color: Constants.meltonBlue),
            backgroundColor: Constants.meltonYellowAccent,
          ),
          BottomNavigationBarItem(
            title: Text("Profile",
                style: TextStyle(
                    color: Constants.meltonBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
            icon: Icon(Icons.person, color: Constants.meltonBlue),
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

  final mailtoLink = Mailto(
    to: ['meltonapp@gmail.com'],
    bcc: ['arunjosephraj@gmail.com', 'pranavbijapur@gmail.com'],
    subject: 'Quick question about the App',
    body: 'I am writing this Email from the MF app.',
  );

  void choiceAction(String choice) {
    if (choice == Constants.About) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => About()),
      );
    } else if (choice == Constants.Contact) {
      launch('$mailtoLink');
    } else if (choice == Constants.Privacy) {
      const url = 'https://meltonapp.com/privacy';
      launch(url);
    }
  }
}
