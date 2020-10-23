import 'package:melton_app/util/model_util.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/util/social_media.dart';

class ProfileModel {
  String email;
  String name;
  bool isJuniorFellow;
  int points;
  String campus;
  String city;
  String country;
  int batch;
  String bio;
  String work;
  PhoneNumber phoneNumber;
  SocialMediaAccounts socialMediaAccounts;
  SDGList SDGs;
  String picture;

  ProfileModel({this.email, this.name, this.isJuniorFellow, this.points,
  this.campus, this.city, this.country, this.batch, this.bio, this.work, this.phoneNumber,
  this.socialMediaAccounts, this.SDGs, this.picture});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['profile']['user']['email'],
      name: json['profile']['name'],
      isJuniorFellow: json['profile']['isJuniorFellow'],
      points: json['profile']['points'],
      campus: json['profile']['campus'],
      city: validateCity(json['profile']['city'], json['profile']['country']),
      batch: json['profile']['batch'],
      bio: json['profile']['bio'],
      work: json['profile']['work'],
      phoneNumber: PhoneNumber.fromJson(json['profile']['phoneNumber']),
      socialMediaAccounts: SocialMediaAccounts.fromJson(new List<dynamic>.from(json['profile']['socialMediaAccounts'])),
      SDGs: SDGList.fromJson(new List<int>.from(json['profile']['sdgs'])),
      picture: json['profile']['picture'],
    );
  }

  static Map<String, dynamic> toJson(ProfileModel model) {
    return {
      "name": model.name,
      "campus": model.campus,
      "city": model.city,
      "country": model.country,
      "batch": model.batch,
      "bio": model.bio,
      "work": model.work,
      "phoneNumber": PhoneNumber.toJson(model.phoneNumber),
      "socialMediaAccounts": SocialMediaAccounts.toJson(model.socialMediaAccounts),
      "sdgs": SDGList.toJson(model.SDGs)
    };
  }
}

class SDGList {
  int firstSDG = 0;
  int secondSDG = 0;
  int thirdSDG = 0;

  SDGList.profileUpdateConstructor();

  SDGList(List<int> sdgList) {
    firstSDG = sdgList[0];
    secondSDG = sdgList[1];
    thirdSDG = sdgList[2];
  }

  factory SDGList.fromJson(List<int> responseSDGs) {
    List<int> sdg_list = [0, 0, 0];
    if (responseSDGs == null) {
      return SDGList(sdg_list);
    }
    for (int i = 0; i < responseSDGs.length && i < 3; i++) {
      if (responseSDGs[i].toInt() >= Constants.MIN_SDG_CODE && responseSDGs[i].toInt() <= Constants.MAX_SDG_CODE) {
        sdg_list[i] = responseSDGs[i].toInt();
      }
    }
    return SDGList(sdg_list);
  }

  static List<dynamic> toJson(SDGList model) {
    List<dynamic> returnList = [];
    if (model.firstSDG != null) {
      returnList.add(model.firstSDG);
    }
    if (model.secondSDG != null) {
      returnList.add(model.secondSDG);
    }
    if (model.thirdSDG != null) {
      returnList.add(model.thirdSDG);
    }
    return returnList;
  }
}

class SocialMediaAccounts {
  String facebook;
  String instagram;
  String twitter;
  String wechat;
  String linkedin;
  List<String> others;

  SocialMediaAccounts({this.facebook, this.instagram, this.twitter, this.wechat,
  this.linkedin, this.others});

  factory SocialMediaAccounts.fromJson(List<dynamic> responseSocialMediaAccounts) {
    SocialMediaAccounts socialMediaAccounts = SocialMediaAccounts(others: new List<String>());
    for (int i = 0; i < responseSocialMediaAccounts.length; i++) {
      try {
        responseSocialMediaAccounts[i] = new Map<String, String>.from(responseSocialMediaAccounts[i]);
      } catch (e) {
        continue;
      }

      if (validateAccount(responseSocialMediaAccounts[i], "facebook")) {
        socialMediaAccounts.facebook = responseSocialMediaAccounts[i]['account'].toLowerCase();
      } else if (validateAccount(responseSocialMediaAccounts[i], "instagram")) {
        socialMediaAccounts.instagram = responseSocialMediaAccounts[i]['account'].toLowerCase();
      } else if (validateAccount(responseSocialMediaAccounts[i], "twitter")) {
        socialMediaAccounts.twitter = responseSocialMediaAccounts[i]['account'].toLowerCase();
      } else if (validateAccount(responseSocialMediaAccounts[i], "wechat")) {
        socialMediaAccounts.wechat = responseSocialMediaAccounts[i]['account'].toLowerCase();
      } else if (validateAccount(responseSocialMediaAccounts[i], "linkedin")) {
        socialMediaAccounts.linkedin = responseSocialMediaAccounts[i]['account'].toLowerCase();
      } else if (validateAccount(responseSocialMediaAccounts[i], "other")) {
        // only first 3 "other" links are considered
        if (socialMediaAccounts.others.length == 3) {
          continue;
        }
        socialMediaAccounts.others.add(responseSocialMediaAccounts[i]['account']);
      }
    }
    return socialMediaAccounts;
  }

  static List<dynamic> toJson(SocialMediaAccounts model) {
    List<dynamic> returnList = [];
    if (model.facebook != null && model.facebook.length > 0) {
      appendMapToList(SocialMedia.FACEBOOK_KEY, model.facebook, returnList);
    }
    if (model.instagram != null && model.instagram.length > 0) {
      appendMapToList(SocialMedia.INSTAGRAM_KEY, model.instagram, returnList);
    }
    if (model.twitter != null && model.twitter.length > 0) {
      appendMapToList(SocialMedia.TWITTER_KEY, model.twitter, returnList);
    }
    if (model.wechat != null && model.wechat.length > 0) {
      appendMapToList(SocialMedia.WECHAT_KEY, model.wechat, returnList);
    }
    if (model.linkedin != null && model.linkedin.length > 0) {
      appendMapToList(SocialMedia.LINKEDIN_KEY, model.linkedin, returnList);
    }
    if (model.others != null && model.others.length > 0) {
      if (model.others[0].length > 0) {
        appendMapToList(SocialMedia.OTHER_KEY, model.others[0], returnList);
      }
      if (model.others.length > 1) {
        if (model.others[1].length > 0) {
          appendMapToList(SocialMedia.OTHER_KEY, model.others[1], returnList);
        }
      }
    }
    return returnList;
  }

  static void appendMapToList(String key, String value, List<dynamic> list) {
    list.add({
      "type": key,
      "account": value,
    });
  }

  static bool validateAccount(Map<String, String> account, String type) {
    if (type == "other") {
      return (account['account'].toLowerCase().startsWith(SocialMedia.HTTP) ||
          account['account'].toLowerCase().startsWith(SocialMedia.HTTPS));
    } else if (type == "wechat") {
      return account['type'].toLowerCase() == type && account['account'].length > 0;
    }
    return account['type'].toLowerCase() == type
        && account['account'].toLowerCase().startsWith(SocialMedia.HTTPS);
  }

}

class PhoneNumber {
  String countryCode;
  String phoneNumber;

  PhoneNumber({this.countryCode, this.phoneNumber});

  factory PhoneNumber.fromJson(List<dynamic> responsePhoneNumbers) {
    if (responsePhoneNumbers == null) {
      return PhoneNumber(countryCode: "", phoneNumber: "");
    }
    for (int i = 0; i < responsePhoneNumbers.length; i++) {
      try {
        Map<String, String> responsePhoneNumber = new Map<String, String>.from(responsePhoneNumbers[i]);
        if (responsePhoneNumber['number'].length == 0) {
          continue;
        }
        // only first phone number is returned
        return PhoneNumber(countryCode: responsePhoneNumber['countryCode'],
            phoneNumber: responsePhoneNumber['number']);
      } catch (e) {
        continue;
      }
    }
    return PhoneNumber(countryCode: "", phoneNumber: "");
  }

  static List<dynamic> toJson(PhoneNumber model) {
    List<dynamic> returnList = [];
    if (model.phoneNumber != null && model.phoneNumber.length > 0 &&
        model.countryCode!= null && model.countryCode.length > 0) {
      returnList.add({
        "number": model.phoneNumber,
        "countryCode": model.countryCode
      });
    }
    return returnList;
  }

}
