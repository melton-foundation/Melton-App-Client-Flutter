import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:melton_app/util/url_launch_util.dart';
import 'package:melton_app/constants/constants.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 75.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/mf_logo_faces.png",
                  fit: BoxFit.cover,
                ),
                getTitleSection(),
                getTextSection(),
                getSocialMediaSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getTitleSection() {
  return Text(
    "Melton Foundation",
    textAlign: TextAlign.center,
    style: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 30, color: Constants.meltonBlue),
  );
}

Widget getTextSection() {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      "The Melton App was made by and made for Melton Fellows. You can find exciting Fellows projects, view the Fellows directory and find Fellows in many cities of the world using the Fellows Map."
      "\n\nThe Melton Foundation promotes and enables global citizenship as a way for individuals and organizations to work together across boundaries of place and identity to address global challenges.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
      ),
      softWrap: true,
    ),
  );
}

Widget getSocialMediaSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      getSocialMediaIconButton(FontAwesomeIcons.linkedin, HexColor("#2867B2"),
          Constants.MELTON_LINKEDIN_URL),
      getSocialMediaIconButton(FontAwesomeIcons.facebook, HexColor("#3B5998"),
          Constants.MELTON_FACEBOOK_URL),
      getSocialMediaIconButton(FontAwesomeIcons.instagram, HexColor("#C13584"),
          Constants.MELTON_INSTAGRAM_URL),
      getSocialMediaIconButton(FontAwesomeIcons.twitter, HexColor("#1DA1F2"),
          Constants.MELTON_TWITTER_URL),
      getSocialMediaIconButton(FontAwesomeIcons.youtube, HexColor("#FF0000"),
          Constants.MELTON_YOUTUBE_URL),
      getSocialMediaIconButton(
          FontAwesomeIcons.link, Colors.black, Constants.MELTON_WEBSITE_URL),
    ],
  );
}

Widget getSocialMediaIconButton(IconData icon, Color color, String url) {
  return IconButton(
      icon: Icon(
        icon,
        color: color,
        size: 30,
      ),
      onPressed: () async {
        launchUrl(url);
      });
}
