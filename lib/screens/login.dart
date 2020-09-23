import 'package:flutter/material.dart';

import 'dart:io' show Platform;

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/UserRegistrationStatusModel.dart';
import 'package:melton_app/screens/authorization_wall.dart';
import 'package:melton_app/util/persistent_storage.dart';
import 'package:melton_app/screens/main_home.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/util/token_handler.dart';
import 'package:melton_app/screens/components/sign_up.dart';
import 'package:melton_app/screens/splash.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email", "profile"]);

  final Widget empty = Container(width: 0.0, height: 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Constants.meltonGreenAccent, Constants.meltonYellowAccent]//, Constants.meltonBlueAccent, Constants.meltonGreenAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/errors/welcome_screen.png"),
              WelcomeText("WELCOME TO THE MELTON APP!"),
              WelcomeText("Only Melton Fellows can use this app. "),
              WelcomeText("Your data is used solely by the Melton Foundation. For more details see: meltonapp.com/privacy"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/google.png"),
                  RaisedButton(onPressed: () {
                    triggerLogin(true);
                  },
                  child: Text("SIGN IN WITH GOOGLE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  color: Constants.meltonBlueAccent,
                  splashColor: Constants.meltonRed,
                  ),
                ],
              ),
              Platform.isIOS ?
              SignInWithAppleButton(
                onPressed: () async {
                  triggerLogin(false);
                  },
              ) : empty,
              RaisedButton(onPressed: () {
                triggerRegister();
              },
                child: Text("SIGN UP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                color: Constants.meltonBlue,
                splashColor: Constants.meltonYellow,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> triggerLogin(bool isGoogleLogin) async {
    UserRegistrationStatusModel tokenOrUnauthorized;
    if (isGoogleLogin) {
      tokenOrUnauthorized = await oauthGoogleLoginAndGetAppToken();
    } else {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // TODO email and full name are only sent the first time. save it?
      // what about new device?
      // just mark this as enhancement and lave for later?
      print(credential);
      print(credential.email);
      print(credential.authorizationCode);

      tokenOrUnauthorized = await ApiService().getAppToken(credential.email, credential.authorizationCode, "APPLE");
    }
    if (tokenOrUnauthorized?.appToken != null) {
      PersistentStorage storage = GetIt.I.get<PersistentStorage>();
      await storage.saveStringToStorage(TokenHandler.APP_TOKEN_KEY, tokenOrUnauthorized.appToken);
      await GetIt.I.get<TokenHandler>().refresh(storage);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return MyHomePage();
      }));
    } else if (tokenOrUnauthorized?.isApproved == false) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return AuthorizationWall();
      }));
    } else {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return SplashScreen();
      }));
    }

  }

  Future<UserRegistrationStatusModel> oauthGoogleLoginAndGetAppToken() async {
    UserRegistrationStatusModel tokenOrUnauthorized;
    await _googleSignIn.signIn().then((result) async {
      await result.authentication.then((googleKey) async {
        tokenOrUnauthorized = await ApiService().getAppToken(result.email, googleKey.idToken, "GOOGLE");
      }).catchError((err) {
        print('oauth inner error'); //todo error screen
      });
    }).catchError((err) {
      print('oauth error occured'); //todo error screen
    });
    return tokenOrUnauthorized;
  }

  Future<String> triggerRegister() async {
    showModalBottomSheet(context: context, isScrollControlled: true,
        builder: (BuildContext context) {
      return SignUp();
    });
  }

}

class WelcomeText extends StatelessWidget {
  final String text;

  WelcomeText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
      color: Colors.white),);
  }
}


