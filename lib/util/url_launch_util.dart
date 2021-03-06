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

launchTelOrMailtoUrl(String url, bool isTel) async {
  if (isTel) {
    url = url.replaceAll(" ", "");
    url = "tel://+" + url;
  } else {
    //isEmail
    url = "mailto:" +
        url +
        "?subject=Hey!%20I%20found%20you%20on%20the%20MF%20App";
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
