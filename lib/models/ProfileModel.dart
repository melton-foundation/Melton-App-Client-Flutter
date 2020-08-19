class ProfileModel {
  String email;
  String name;
  bool isJuniorFellow;
  int points;
  String campus;
  String city;
  int batch;
  String work;
  String phoneNumber;
  SocialMediaAccounts socialMediaAccounts;
  SDGList SDGs;
  String picture;

  ProfileModel({this.email, this.name, this.isJuniorFellow, this.points,
  this.campus, this.city, this.batch, this.work, this.phoneNumber,
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
      work: json['profile']['work'],
      phoneNumber: json['phoneNumber'], //todo
      socialMediaAccounts: SocialMediaAccounts.fromJson(new List<dynamic>.from(json['profile']['socialMediaAccounts'])),
      SDGs: SDGList.fromJson(new List<int>.from(json['profile']['sdgs'])),
      picture: json['profile']['picture'],
    );
  }

  static String validateCity(String city, String country) {
    if (city.length == 0 && country.length == 0) {
      return "";
    } else {
      return city + ", " + country;
    }
  }
}

class SDGList {
  int firstSDG = 0;
  int secondSDG = 0;
  int thirdSDG = 0;

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
      sdg_list[i] = responseSDGs[i].toInt();
    }
    return SDGList(sdg_list);
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

  static bool validateAccount(Map<String, String> account, String type) {
    if (type == "other") {
      return account['account'].toLowerCase().startsWith("https://");
    }
    return account['type'].toLowerCase() == type
        && account['account'].toLowerCase().startsWith("https://");
  }

}

class PhoneNumber {
  String countryCode;
  String phoneNumber;

  PhoneNumber({this.countryCode, this.phoneNumber});

  factory PhoneNumber.fromJson(List<dynamic> responsePhoneNumbers) {
    for (int i = 0; i < responsePhoneNumbers.length; i++) {
      try {
        Map<String, String> responsePhoneNumber = responsePhoneNumbers[i];
        // only first phone number is returned
        return PhoneNumber(countryCode: responsePhoneNumber['countryCode'],
            phoneNumber: responsePhoneNumber['phoneNumber']);
      } catch (e) {
        continue;
      }
    }
    return PhoneNumber(countryCode: "", phoneNumber: "");
  }

}