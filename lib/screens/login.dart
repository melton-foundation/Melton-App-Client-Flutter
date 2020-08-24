import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:melton_app/util/secrets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(clientId: Secrets.GOOGLE_OAUTH_CLIENT_ID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("WELCOME TO THE MELTON APP!"),
          Text("We need you to sign in with Google to prove that you are a Melton Fellow."),
          Text("We will use the profile picture and email. "),
          Text(""),
          Text("For a detailed overview, see our privacy policy here: meltonapp.com/privacy"), //todo add link
          RaisedButton(onPressed: () {

          },
          child: Text("SIGN IN"),),
        ],
      ),
    );
  }
}
