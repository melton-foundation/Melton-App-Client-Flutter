import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(About());

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: About_Container(),
      ),
    );
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.all(5),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 0),
              child: Text(
                'Melton Foundation App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

Widget buttonSection = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
          icon: Icon(
            FontAwesomeIcons.linkedin,
            color: HexColor("#2867B2"),
            size: 30,
          ),
          onPressed: () async {
            const url = 'https://www.linkedin.com/company/meltonfoundation/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch. Try Again !';
            }
          }),
      IconButton(
          icon: Icon(
            FontAwesomeIcons.facebook,
            color: HexColor("#3b5998"),
            size: 30,
          ),
          onPressed: () async {
            const url = 'https://www.facebook.com/meltonfoundation';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch. Try Again !';
            }
          }),
      IconButton(
          icon: Icon(
            FontAwesomeIcons.instagram,
            color: HexColor("#C13584"),
            size: 30,
          ),
          onPressed: () async {
            const url = 'https://www.instagram.com/meltonfoundation/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch. Try Again !';
            }
          }),
      IconButton(
          icon: Icon(
            FontAwesomeIcons.twitter,
            color: HexColor("#1da1f2"),
            size: 30,
          ),
          onPressed: () async {
            const url = 'https://twitter.com/MFGlobalCitizen';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch. Try Again !';
            }
          }),
      IconButton(
          icon: Icon(
            FontAwesomeIcons.youtube,
            color: HexColor("#ff0000"),
            size: 30,
          ),
          onPressed: () async {
            const url = 'https://www.youtube.com/user/TheMeltonFoundation';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch. Try Again !';
            }
          }),
      IconButton(
          icon: Icon(
            FontAwesomeIcons.link,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () async {
            const url = 'https://meltonfoundation.org/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch. Try Again !';
            }
          }),
    ],
  ),
);

Widget textSection = Container(
  padding: const EdgeInsets.all(32),
  child: Text(
    'The Melton Foundation promotes and enables global citizenship as a way for individuals and organizations to work'
    'together across boundaries of place and identity to address global challenges.\n'
    'This app was developed to be the one stop shop for all things related to Melton.\n'
    'Have fun using it !! Cheers !!!',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 18,
    ),
    softWrap: true,
  ),
);

class About_Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/fellows_faces.png',
          fit: BoxFit.cover,
        ),
        titleSection,
        textSection,
        buttonSection,
      ],
    );
  }
}
