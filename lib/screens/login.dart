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
import 'package:melton_app/util/text_util.dart';
import 'package:melton_app/util/token_handler.dart';
import 'package:melton_app/screens/components/sign_up.dart';
import 'package:melton_app/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:melton_app/util/url_launch_util.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email", "profile"]);

  final Widget empty = Container(width: 0.0, height: 0.0);
  bool privacyPolicyCheckboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Constants.meltonGreenAccent,
                Constants.meltonYellowAccent
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/errors/welcome_screen.png"),
              WelcomeText("WELCOME TO THE MELTON APP!"),
              WelcomeText(
                  "You can Sign In with a Melton-registered email or Sign Up to get started!"),
              InkWell(
                child: Text("meltonapp.com/privacy",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Constants.meltonBlue)),
                onTap: () {
                  launchUrlWebview("https://meltonapp.com/privacy/");
                },
              ),
              CheckboxListTile(
                title: WhiteSubtitleText(
                    content: "I have read and accept the Privacy Policy"),
                value: privacyPolicyCheckboxValue,
                onChanged: (newValue) {
                  setState(() {
                    privacyPolicyCheckboxValue = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/google.png"),
                  RaisedButton(
                    onPressed: privacyPolicyCheckboxValue
                        ? () {
                            triggerLogin(true);
                          }
                        : () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Accept the Privacy Policy"),
                                    content: Text(
                                        "You need to accept the Privacy Policy to use the app."),
                                    actions: [
                                      FlatButton(
                                        child: Text("OK",
                                            style: TextStyle(
                                                color: Constants.meltonBlue)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                    child: Text(
                      "SIGN IN WITH GOOGLE",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Constants.meltonBlueAccent,
                  ),
                ],
              ),
              Platform.isIOS
                  ? SignInWithAppleButton(
                      onPressed: privacyPolicyCheckboxValue
                          ? () async {
                              triggerLogin(false);
                            }
                          : () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Accept the Privacy Policy"),
                                      content: Text(
                                          "You need to accept the Privacy Policy to use the app."),
                                      actions: [
                                        FlatButton(
                                          child: Text("OK",
                                              style: TextStyle(
                                                  color: Constants.meltonBlue)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                    )
                  : empty,
              RaisedButton(
                onPressed: () {
                  triggerRegister();
                },
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Constants.meltonBlue,
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
      String appleEmail;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (credential.email == null) {
        appleEmail = preferences.getString(TokenHandler.APPLE_EMAIL_KEY);
      } else {
        await preferences.setString(
            TokenHandler.APPLE_EMAIL_KEY, credential.email);
        appleEmail = credential.email;
      }
      tokenOrUnauthorized = await ApiService()
          .getAppToken(appleEmail, credential.authorizationCode, "APPLE");
    }
    if (tokenOrUnauthorized?.appToken != null) {
      PersistentStorage storage = GetIt.instance.get<PersistentStorage>();
      await storage.saveStringToStorage(
          TokenHandler.APP_TOKEN_KEY, tokenOrUnauthorized.appToken);
      await GetIt.instance.get<TokenHandler>().refresh(storage);
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
        tokenOrUnauthorized = await ApiService()
            .getAppToken(result.email, googleKey.idToken, "GOOGLE");
      }).catchError((err) {
        //todo error screen
      });
    }).catchError((err) {
      //todo error screen
    });
    return tokenOrUnauthorized;
  }

  Future<void> triggerRegister() async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
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
    return Text(
      text,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
