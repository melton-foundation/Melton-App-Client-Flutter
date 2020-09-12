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

  static const Color userSearchFilters = Color.fromRGBO(57, 93, 115, 1.0);
  static const Color directoryBackground = Color.fromRGBO(0, 40, 66, 1.0);
  static const Color userTileFooterColor = Colors.red;

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

  static const placeholder_avatar = "assets/profile_avatar_placeholder_256px.png";

//todo alafia to get back on WU
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

}