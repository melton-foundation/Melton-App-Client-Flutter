import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:melton_app/constants/constants.dart';

import 'package:melton_app/models/ProfileModel.dart';

class SocialMedia {
  static const FACEBOOK = "Facebook";
  static const INSTAGRAM = "Instagram";
  static const TWITTER = "Twitter";
  static const WECHAT = "Wechat/Weixin ID";
  static const LINKEDIN = "Linkedin";
  static const OTHER = "Other";

  static const FACEBOOK_KEY = "facebook";
  static const INSTAGRAM_KEY = "instagram";
  static const TWITTER_KEY = "twitter";
  static const WECHAT_KEY = "wechat";
  static const LINKEDIN_KEY = "linkedin";
  static const OTHER_KEY = "other";
  static const OTHER1_KEY = "other1";
  static const OTHER2_KEY = "other2";

  static const HTTPS = "https://";
  static const HTTP = "http://";
  static const FACEBOOK_URL = "facebook.com/";
  static const INSTAGRAM_URL = "instagram.com/";
  static const TWITTER_URL = "twitter.com/";
  static const LINKEDIN_URL = "linkedin.com/";
  static const COM_ENDING = ".com/";

  static const Map<String, String> KEY_URL_MAP = {
    FACEBOOK_KEY: FACEBOOK_URL,
    INSTAGRAM_KEY: INSTAGRAM_URL,
    TWITTER_KEY: TWITTER_URL,
    LINKEDIN_KEY: LINKEDIN_URL,
    OTHER1_KEY: HTTP,
    OTHER2_KEY: HTTP
  };

  static String getSocialMediaAccountOrPlaceholder(
      SocialMediaAccounts accounts, String key) {
    switch (key) {
      case SocialMedia.FACEBOOK_KEY:
        {
          return accounts.facebook ??
              (SocialMedia.HTTPS + SocialMedia.KEY_URL_MAP[key]);
        }
        break;
      case SocialMedia.INSTAGRAM_KEY:
        {
          return accounts.instagram ??
              (SocialMedia.HTTPS + SocialMedia.KEY_URL_MAP[key]);
        }
        break;
      case SocialMedia.TWITTER_KEY:
        {
          return accounts.twitter ??
              (SocialMedia.HTTPS + SocialMedia.KEY_URL_MAP[key]);
        }
        break;
      case SocialMedia.WECHAT_KEY:
        {
          return accounts.wechat;
        }
        break;
      case SocialMedia.LINKEDIN_KEY:
        {
          return accounts.linkedin ??
              (SocialMedia.HTTPS + SocialMedia.KEY_URL_MAP[key]);
        }
        break;
      case SocialMedia.OTHER1_KEY:
        {
          return accounts.others.length >= 1 ? accounts.others[0] : null;
        }
        break;
      case SocialMedia.OTHER2_KEY:
        {
          return accounts.others.length >= 2 ? accounts.others[1] : null;
        }
        break;
    }
    return null;
  }

  static void setSocialMediaAccount(
      SocialMediaAccounts accounts, String key, String value) {
    switch (key) {
      case SocialMedia.FACEBOOK_KEY:
        {
          accounts.facebook = value;
        }
        break;
      case SocialMedia.INSTAGRAM_KEY:
        {
          accounts.instagram = value;
        }
        break;
      case SocialMedia.TWITTER_KEY:
        {
          accounts.twitter = value;
        }
        break;
      case SocialMedia.WECHAT_KEY:
        {
          accounts.wechat = value;
        }
        break;
      case SocialMedia.LINKEDIN_KEY:
        {
          accounts.linkedin = value;
        }
        break;
      case SocialMedia.OTHER1_KEY:
        {
          if (accounts.others.length >= 1) {
            accounts.others[0] = value;
          } else {
            accounts.others.clear();
            accounts.others.add(value);
          }
        }
        break;
      case SocialMedia.OTHER2_KEY:
        {
          if (accounts.others.length >= 2) {
            accounts.others[1] = value;
          } else if (accounts.others.length == 1) {
            accounts.others.add(value);
          } else {
            accounts.others.clear();
            accounts.others.add(value);
          }
        }
        break;
    }
  }

  static bool isSocialMediaFormatted(String key, String value) {
    if (key == SocialMedia.WECHAT_KEY) {
      return true; // no validation for wechat/weixin ID
    }

    if (key == SocialMedia.OTHER1_KEY || key == SocialMedia.OTHER2_KEY) {
      return (value.startsWith(SocialMedia.HTTP) ||
          value.startsWith(SocialMedia.HTTPS));
    }

    return value.startsWith(SocialMedia.HTTPS) &&
        value.contains(SocialMedia.KEY_URL_MAP[key]) &&
        !value.endsWith(SocialMedia.COM_ENDING);
  }

  static getInputDecorationFromKey(String key) {
    switch (key) {
      case FACEBOOK_KEY:
        {
          return InputDecoration(
            border: OutlineInputBorder(),
            labelText: FACEBOOK,
            icon: Icon(
              FontAwesomeIcons.facebook,
              color: Constants.meltonBlue,
            ),
          );
        }
        break;
      case INSTAGRAM_KEY:
        {
          return InputDecoration(
            border: OutlineInputBorder(),
            labelText: INSTAGRAM,
            icon: Icon(
              FontAwesomeIcons.instagram,
              color: Constants.meltonRedAccent,
            ),
          );
        }
        break;
      case TWITTER_KEY:
        {
          return InputDecoration(
            border: OutlineInputBorder(),
            labelText: TWITTER,
            icon: Icon(
              FontAwesomeIcons.twitter,
              color: Constants.meltonBlueAccent,
            ),
          );
        }
        break;
      case WECHAT_KEY:
        {
          return InputDecoration(
            border: OutlineInputBorder(),
            labelText: WECHAT,
            icon: Icon(
              FontAwesomeIcons.weixin,
              color: Constants.meltonGreenAccent,
            ),
          );
        }
        break;
      case LINKEDIN_KEY:
        {
          return InputDecoration(
            border: OutlineInputBorder(),
            labelText: LINKEDIN,
            icon: Icon(
              FontAwesomeIcons.linkedin,
              color: Constants.meltonBlueAccent,
            ),
          );
        }
        break;
      default:
        {
          return InputDecoration(
            border: OutlineInputBorder(),
            labelText: OTHER,
            icon: Icon(
              FontAwesomeIcons.globeAmericas,
              color: Constants.meltonBlueAccent,
            ),
          );
        }
        break;
    }
  }
}
