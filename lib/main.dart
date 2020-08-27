import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;
import 'package:melton_app/screens/login.dart';
import 'package:melton_app/screens/profile.dart';
import 'package:melton_app/screens/splash.dart';
import 'package:melton_app/screens/main_home.dart';

bool _isLoggedIn = false;

void main() async {
  _isLoggedIn = false;
//  _isLoggedIn = await checkOAuthLoggedIn(); //todo
  runApp(MyApp());
}

//todo
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
        "/": (context) => SplashScreen(),
        "/profile_view": (context) => Profile(),
//        "/profile_update": ProfileUpdate(),
//        "directory": Directory(),
//        "news": News(),
      },
//      home: MyHomePage(title: 'Melton Foundation'),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) {
              // todo remove?
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
    );
  }
}

