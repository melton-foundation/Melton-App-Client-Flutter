import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;
import 'package:melton_app/screens/login.dart';
import 'package:melton_app/screens/profile.dart';
import 'package:melton_app/screens/directory.dart';
import 'package:melton_app/screens/home.dart';


bool _isLoggedIn = false;

void main() async {
  _isLoggedIn = await checkOAuthLoggedIn();
  runApp(MyApp());
}

Future<bool> checkOAuthLoggedIn() {
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melton Foundation',
      initialRoute: "/", //for debugging, TODO remove
      routes: {
//        "/": (context) => Profile(),
        "/profile_view": (context) => Profile(),
//        "/profile_update": ProfileUpdate(),
//        "directory": Directory(),
//        "news": News(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) {
              return _isLoggedIn ? Profile() : LoginScreen();
            });
          default:
            return MaterialPageRoute(builder: (_) {
              return LoginScreen();
            });
        }
      },
      theme: ThemeData(
        primarySwatch: Constants.meltonMaterialBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Melton Foundation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentScreenIndex = 2;

  final screens = [
    Directory(),
    Home(),
    Profile(),
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
