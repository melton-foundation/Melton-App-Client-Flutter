import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:melton_app/api/api.dart';
import 'package:melton_app/screens/login.dart';
import 'package:melton_app/screens/main_home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/splash.png"),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }


//todo use "signinsilently"?
  Future<void> isLoggedIn() async {
    bool isAppTokenValid = await GetIt.I.get<ApiService>().verifyAppTokenValid();

    if (isAppTokenValid) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return MyHomePage();
      }));
    } else {
      print('pushing loginscreen');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return LoginScreen();
      }));
    }
  }

}