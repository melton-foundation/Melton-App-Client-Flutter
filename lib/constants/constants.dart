import 'dart:collection';

import 'package:flutter/material.dart';

class Constants {
  static const Color meltonBlue = Color.fromRGBO(0, 66, 119, 1.0);
  static const Color meltonRed = Color.fromRGBO(178, 10, 38, 1.0);
  static const Color meltonYellow = Color.fromRGBO(229, 155, 26, 1.0);
  static const Color meltonGreen = Color.fromRGBO(0, 115, 53, 1.0);

  static const Color meltonBlueAccent = Color.fromRGBO(0, 124, 224, 1.0);
  static const Color meltonRedAccent = Color.fromRGBO(194, 89, 107, 1.0);
  static const Color meltonYellowAccent = Color.fromRGBO(230, 178, 90, 1.0);
  static const Color meltonGreenAccent = Color.fromRGBO(106, 173, 137, 1.0);

  static const Color directoryBackground = Color.fromRGBO(0, 59, 98, 1.0);

  static const List<Color> meltonRedYellowGreen = [
    meltonRed,
    meltonYellow,
    meltonGreen
  ];

  static const MaterialColor meltonMaterialBlue = MaterialColor(0xFF004277, {
    50: Color.fromRGBO(0, 66, 119, 1.0),
    100: Color.fromRGBO(0, 66, 119, 1.0),
    200: Color.fromRGBO(0, 66, 119, 1.0),
    300: Color.fromRGBO(0, 66, 119, 1.0),
    400: Color.fromRGBO(0, 66, 119, 1.0),
    500: Color.fromRGBO(0, 66, 119, 1.0),
    600: Color.fromRGBO(0, 66, 119, 1.0),
    700: Color.fromRGBO(0, 66, 119, 1.0),
    800: Color.fromRGBO(0, 66, 119, 1.0),
    900: Color.fromRGBO(0, 66, 119, 1.0),
  });

  static const APPBAR_ABOUT = "About";
  static const APPBAR_PRIVACY_POLICY = "Privacy Policy";
  static const APPBAR_HELP = "Help";

  static const MELTON_PRIVACY_POLICY_URL = "https://meltonapp.com/privacy";
  static const MELTON_LINKEDIN_URL = "https://www.linkedin.com/company/meltonfoundation/";
  static const MELTON_FACEBOOK_URL = "https://www.facebook.com/meltonfoundation";
  static const MELTON_INSTAGRAM_URL = "https://www.instagram.com/meltonfoundation/";
  static const MELTON_TWITTER_URL = "https://twitter.com/MFGlobalCitizen";
  static const MELTON_YOUTUBE_URL = "https://www.youtube.com/user/TheMeltonFoundation";
  static const MELTON_WEBSITE_URL = "https://meltonfoundation.org/";

  static const placeholder_avatar = "assets/profile_avatar_placeholder_256px.png";

  static const List<String> campuses = [
    "AU / Accra",
    "BMS / Bangalore",
    "DU / New Orleans",
    "FSU / Jena",
    "UFRO / Temuco",
    "ZU / Hangzhou",
    "Westmar University",
    "Other"
  ];

  static const List<String> meltonCities = [
    "Accra, Ghana",
    "Bengaluru, India",
    "Hangzhou, China",
    "Jena, Germany",
    "New Orleans, United States",
    "Temuco, Chile",
  ];

  static const int MIN_SDG_CODE = 1;
  static const int MAX_SDG_CODE = 17;

  // LinkedHashMap needed to maintain order
  static final Map<int, String> SDGs = new LinkedHashMap.from({
    1  : "No Poverty",
    2  : "Zero Hunger",
    3  : "Good Health and Well-being",
    4  : "Quality Education",
    5  : "Gender Equality",
    6  : "Clean Water and Sanitation",
    7  : "Affordable and Clean Energy",
    8  : "Decent Work and Economic Growth",
    9  : "Industry, Innovation, and Infrastructure",
    10 : "Reducing Inequality",
    11 : "Sustainable Cities and Communities",
    12 : "Responsible Consumption and Production",
    13 : "Climate Action",
    14 : "Life Below Water",
    15 : "Life On Land",
    16 : "Peace, Justice, and Strong Institutions",
    17 : "Partnerships for the Goals",
  });

  static const String FILTERS = "FL";

}