import 'package:url_launcher/url_launcher.dart';

void launchUrlWebview(String url) async {
  if (await canLaunch(url)) {
    launch(url, forceSafariVC: true, forceWebView: false);
  }
}

//todo test on android and ios
launchSocialMediaUrl(String url) async {
  if (await canLaunch(url)) {
    bool nativeLaunchSuccess =
        await launch(url, forceSafariVC: false, universalLinksOnly: true);
    if (!nativeLaunchSuccess) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    }
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
  if (await canLaunch(url)) {
    launch(url);
  }
}

launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
