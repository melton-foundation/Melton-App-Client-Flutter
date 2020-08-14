import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;
import 'package:melton_app/screens/profile.dart';
import 'package:melton_app/screens/directory.dart';
import 'package:melton_app/screens/news.dart';


void main() {
  runApp(MyApp());
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
    News(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
//            Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
//            Image.asset("assets/icon.png", fit: BoxFit.cover), //todo fix icon
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
            title: Text("News", style: TextStyle(color: Constants.meltonBlue,
                fontWeight: FontWeight.bold, fontSize: 16.0)),
            icon: Icon(Icons.group, color: Constants.meltonBlue),
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
