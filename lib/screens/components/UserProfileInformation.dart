import 'package:flutter/material.dart';

import 'package:melton_app/models/ProfileModel.dart';

import 'package:melton_app/screens/components/profile_line_item_selectable.dart';
import 'package:melton_app/screens/components/JF_badge.dart';
import 'package:melton_app/screens/components/profile_line_item.dart';
import 'package:melton_app/screens/components/profile_photo.dart';
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

Widget getProfileLineItemIfNotNullOrEmpty(String label, String content) {
  if (content == null || content.length == 0) {
    return empty;
  }
  return ProfileLineItem(label: label, content: content);
}

Widget getProfileLineItem(String label, String content) {
  return ProfileLineItem(label: label, content: content);
}

Widget getTelephoneProfileLineItem(String phoneNumber, String countryCode) {
  return !(phoneNumber.length > 0 && countryCode.length > 0)
      ? empty
      : ProfileLineItemSelectable(
          label: "PHONE", content: "+$countryCode $phoneNumber");
}

Widget getEmailProfileLineItem(String email) {
  return ProfileLineItemSelectable(label: "EMAIL", content: email);
}

Widget getUsersSDGInfo(SDGList SDGs) {
  return SDGProfile(
    firstSDG: SDGs.firstSDG,
    secondSDG: SDGs.secondSDG,
    thirdSDG: SDGs.thirdSDG,
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

List<Widget> getUserDetails(
    {bool isProfileModel,
    String picture,
    String name,
    bool isJuniorFellow,
    int points,
    SocialMediaAccounts socialMediaAccounts,
    String bio,
    String work,
    SDGList SDGs,
    String phoneNumber,
    String countryCode,
    String campus,
    int batch,
    String city,
    String email}) {
  return [
    SizedBox(height: 10.0),
    ProfilePhoto(url: picture),
    getProfileLineItemIfNotNull("", name.toUpperCase()),
    Center(child: JFBadge(isJF: isJuniorFellow)),
    getUserImpactPoints(points),
    getUserSocialMediaDetails(socialMediaAccounts),
    getProfileLineItemIfNotNullOrEmpty("BIO", bio),
    getProfileLineItemIfNotNullOrEmpty("WORK", work),
    getUsersSDGInfo(SDGs),
    getTelephoneProfileLineItem(phoneNumber, countryCode),
    getEmailProfileLineItem(email),
    getProfileLineItem("CAMPUS", campus.toUpperCase()),
    getProfileLineItem("JOINED MF IN", batch.toString()),
    getProfileLineItemIfNotNullOrEmpty("CITY", city),
  ];
}
