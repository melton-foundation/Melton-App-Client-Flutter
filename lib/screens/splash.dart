import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_it/get_it.dart';

import 'package:melton_app/api/api.dart';
import 'package:melton_app/screens/login.dart';
import 'package:melton_app/screens/main_home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

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
    bool isLoggedIn = await _googleSignIn.isSignedIn(); //todo needed?
    bool isAppTokenValid = await GetIt.I.get<ApiService>().verifyAppTokenValid();

    //todo remove
    print("isLoggedIn");
    print(isLoggedIn);
    print("isAppTokenValid");
    print(isAppTokenValid);

    // isLoggedIn required?
    if (isLoggedIn && isAppTokenValid) {
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