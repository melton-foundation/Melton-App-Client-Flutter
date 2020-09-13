import 'package:flutter/material.dart';
import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/screens/components/profile_line_item.dart';
import 'package:melton_app/screens/components/sdg_profile.dart';
import 'package:melton_app/screens/components/social_media_line_item.dart';
import 'package:melton_app/screens/components/store_line_item.dart';

final Widget empty = Container(width: 0.0, height: 0.0);

Widget getProfileLineItemIfNotNull(String label, String content) {
  if (content == null) {
    return empty;
  }
  return ProfileLineItem(label: label, content: content);
}

Widget getProfileLineItem(String label, String content) {
  return ProfileLineItem(label: label, content: content);
}

Widget getProfileLineItemIfNotNullAndEmpty(String label, String content) {
  if (content == null && content.length == 0) {
    return empty;
  }
  return ProfileLineItem(label: label, content: content);
}

Widget getUsersSDGInfo(SDGList SDGs) {
  if (SDGs == null) {
    return empty;
  }
  return SDGProfile(
    firstSDG: SDGs.firstSDG,
    secondSDG: SDGs.secondSDG,
    thirdSDG: SDGs.thirdSDG,
  );
}

Widget getUserPhoneNumberDetails(String phoneNumber, String countryCode) {
  return !(phoneNumber.length > 0 && countryCode.length > 0)
      ? empty
      : ProfileLineItem(
          label: "PHONE",
          content: "+" + countryCode + " " + phoneNumber,
        );
}

Widget getUserSocialMediaDetails(SocialMediaAccounts socialMediaAccounts) {
  return SocialMediaLineItem(
    facebook: socialMediaAccounts.facebook,
    instagram: socialMediaAccounts.instagram,
    twitter: socialMediaAccounts.twitter,
    wechat: socialMediaAccounts.wechat,
    linkedin: socialMediaAccounts.linkedin,
    others: socialMediaAccounts.others,
  );
}

Widget getUserImpactPoints(int points) {
  if (points == null) {
    return empty;
  }
  return StoreLineItem(
    key: UniqueKey(),
    points: points,
  );
}
