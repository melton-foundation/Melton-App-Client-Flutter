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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      persistentFooterButtons: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center, //todo fix
          children: [
            IconButton(
              icon:
                Icon(Icons.contacts, color: Constants.meltonBlue),
                onPressed: () {},
                iconSize: 30,
                padding: EdgeInsets.fromLTRB(20, 10, 40, 10), //todo check all paddings, make it relative?
            ),
            Text("Directory"),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.announcement, 
                  color: Constants.meltonBlue), 
              onPressed: () { Navigator.pushNamed(context, "/news"); },
              iconSize: 30,
              padding: EdgeInsets.fromLTRB(40, 10, 40, 10), //todo check all paddings
            ),
            Text("News"),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.person,
                  color: Constants.meltonBlue),
              onPressed: () { Navigator.pushNamed(context, "/profile_view"); },
              iconSize: 30,
              padding: EdgeInsets.fromLTRB(40, 10, 50, 10), //todo check all paddings
            ),
            Text("My Profile"),
          ],
        ),
      ],
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
