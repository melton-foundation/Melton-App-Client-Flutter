import 'package:url_launcher/url_launcher.dart';

void launchUrlWebview(String url) async {
  if (await canLaunch(url)) {
    launch(url, forceSafariVC: true, forceWebView: false);
  } else {
    print("could not launch $url");
  }
}

//todo test on android and ios
launchSocialMediaUrl(String url) async {
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

//todo test on android and ios
launchTelOrMailtoUrl(String url, bool isTel) async {
  if (isTel) {
    url = "tel://+" + url;
  } else {
    //isEmail
    url = "mailto:" + url + "?subject=Hey! I found you on the MF App";
  }
  print("trying " + url);
  if (await canLaunch(url)) {
    launch(url);
  } else {
    //todo handle nicely
    print("could not launch");
  }
}

launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    //todo handle nicely
    print("error: could not launch $url");
  }
}