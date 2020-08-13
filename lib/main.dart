import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;
import 'package:melton_app/screens/profile.dart';


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

  int _currentScreenIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            backgroundColor: Constants.meltonRed,
          ),
          BottomNavigationBarItem(
            title: Text("News", style: TextStyle(color: Constants.meltonBlue,
                fontWeight: FontWeight.bold, fontSize: 16.0)),
            icon: Icon(Icons.announcement, color: Constants.meltonBlue),
            backgroundColor: Constants.meltonYellow,
          ),
          BottomNavigationBarItem(
            title: Text("Profile", style: TextStyle(color: Constants.meltonBlue,
                fontWeight: FontWeight.bold, fontSize: 16.0)),
            icon:  Icon(Icons.person, color: Constants.meltonBlue),
            backgroundColor: Constants.meltonGreen,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentScreenIndex = index;
          });
        },
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              color: Colors.amber,
              child: Text("button 1"),
            ),
            FlatButton(
              onPressed: () {},
              color: Colors.redAccent,
              child: Text("button 2"),
            ),
            FlatButton(
              onPressed: () {},
              color: Colors.purpleAccent,
              child: Text("button 3"),
            ),
          ],
        ),
      ),
    );
  }
}
