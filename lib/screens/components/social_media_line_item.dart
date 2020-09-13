import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:melton_app/constants/constants.dart';

class SocialMediaLineItem extends StatelessWidget {
  final String facebook;
  final String instagram;
  final String twitter;
  final String wechat;
  final String linkedin;
  final List<String> others;

  final Widget empty = Container(width: 0.0, height: 0.0);

  SocialMediaLineItem({this.facebook, this.instagram, this.twitter,
  this.wechat, this.linkedin, this.others});

  @override
  Widget build(BuildContext context) {
    return
      (facebook == null && instagram == null && twitter == null && wechat == null && linkedin == null && others.length == 0)
          ? empty :
      Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.0),
        Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
          child: Text("SOCIAL",
            textAlign: TextAlign.left,
            style: TextStyle(letterSpacing: 2.0,
                color: Constants.meltonBlue,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              facebook == null ? empty : IconButton(
                icon: Icon(FontAwesomeIcons.facebook), onPressed:() {_launchURL(facebook);},
                iconSize: 36.0, color: Constants.meltonBlue,),
              instagram == null ? empty : IconButton(
                icon: Icon(FontAwesomeIcons.instagram), onPressed:() {_launchURL(instagram);},
                iconSize: 36.0, color: Constants.meltonRedAccent,),
              twitter == null ? empty : IconButton(
                icon: Icon(FontAwesomeIcons.twitter), onPressed:() {_launchURL(twitter);},
                iconSize: 36.0, color: Constants.meltonBlueAccent,),
              wechat == null ? empty : IconButton(
                icon: Icon(FontAwesomeIcons.weixin), onPressed:() {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(title: Text("WeChat/Weixin ID"), content: SelectableText(wechat),);
                  });
                },
                iconSize: 36.0, color: Constants.meltonGreenAccent,),
              linkedin == null ? empty : IconButton(
                icon: Icon(FontAwesomeIcons.linkedin), onPressed:() {_launchURL(linkedin);},
                iconSize: 36.0, color: Constants.meltonBlueAccent,),
              others.length == 0 ? empty : IconButton(
                icon: Icon(FontAwesomeIcons.globeAmericas, color: Constants.meltonBlueAccent,),
                onPressed:() {
                  otherLinksDialog(context);
                },
                iconSize: 36.0,),
            ],
          ),
      ],
    );
  }

  otherLinksDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("MORE LINKS", style: TextStyle(color: Constants.meltonBlue, fontWeight: FontWeight.bold),),
        content:
        Container(
          height: 175.0,
          width: 100.0,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: others.map((e) =>
                  RaisedButton(
                    onPressed: () {_launchURL(e);},
                    child: Text(e.split("https://")[1],
                      style: TextStyle(
                        color: Constants.meltonBlueAccent,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  )).toList(),
            ),
          ),
        ),
        actions: [
          MaterialButton(
            elevation: 10.0,
            child: Text("OK", style: TextStyle(color: Constants.meltonBlue, fontWeight: FontWeight.bold),),
            onPressed: () {Navigator.of(context).pop();},
          ),
        ],
      );
    });
  }

  //todo test on android and ios
  _launchURL(String url) async {
    if (await canLaunch(url))  {
      bool nativeLaunchSuccess = await launch(url, forceSafariVC: false, universalLinksOnly: true);
      if (!nativeLaunchSuccess) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      }
    } else {
      //todo handle correctly
      // show toast notification/snackbar?
      print("ERROR: Could not open $url");
    }
  }
}
