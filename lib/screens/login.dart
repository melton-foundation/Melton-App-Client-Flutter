import 'dart:developer'; //todo remove

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/screens/splash.dart';
import 'package:melton_app/util/secrets.dart';
import 'package:melton_app/util/persistent_storage.dart';
import 'package:melton_app/main.dart';
import 'package:melton_app/screens/main_home.dart';

import 'package:melton_app/constants/constants.dart' as Constants;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(clientId: Secrets.GOOGLE_OAUTH_CLIENT_ID,
  scopes: ["email", "profile"]);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.meltonBlue,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WelcomeText("WELCOME TO THE MELTON APP!"),
              WelcomeText("We need you to sign in with Google to prove that you are a Melton Fellow."),
              WelcomeText("We will use your Google profile picture and email. "),
              WelcomeText("Your data is used solely by the Melton Foundation. "),
              WelcomeText("For a detailed overview, see our privacy policy here: meltonapp.com/privacy"), //todo add link
              RaisedButton(onPressed: () {
                triggerLogin();
              },
              child: Text("SIGN IN"),
              color: Constants.meltonYellow,
              splashColor: Constants.meltonRed,
              ),
              RaisedButton(onPressed: () {
                //todo open modal and ask details needed for /register
                triggerLogin();
              },
                child: Text("SIGN UP"),
                color: Constants.meltonBlueAccent,
                splashColor: Constants.meltonRed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //todo use "signinsilently"
  Future<bool> triggerLogin() async {
    print('calling oauth');
    String appToken = await oauthLoginAndGetAppToken();
    print('saving to storage');
    PersistentStorage.saveStringToStorage("appToken", appToken);
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return MyHomePage(title: 'Melton Foundation');
    }));
  }

  Future<String> oauthLoginAndGetAppToken() async {
    await _googleSignIn.signIn().then((result) {
      result.authentication.then((googleKey) async {
        print(googleKey.accessToken);
        log(googleKey.idToken); //todo cleanup
        print(result.email);
        String appToken = await ApiService().getAppToken(result.email, googleKey.idToken);
        return appToken;
//        print(_googleSignIn.currentUser.displayName);
      }).catchError((err) {
        print('oauth inner error'); //todo error screen
      });
    }).catchError((err) {
      print('oauth error occured'); //todo error screen
    });
  }

}

class WelcomeText extends StatelessWidget {
  final String text;

  WelcomeText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
      color: Colors.white),);
  }
}


