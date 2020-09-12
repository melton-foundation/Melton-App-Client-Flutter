import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/screens/profile.dart';
import 'package:melton_app/screens/directory.dart';
import 'package:melton_app/screens/home.dart';

import 'package:melton_app/screens/splash.dart';
import 'package:melton_app/util/service_locator.dart';

// todo optimize imports in all files

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Melton Foundation",
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Constants.meltonMaterialBlue,
        highlightColor: Constants.meltonBlueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

