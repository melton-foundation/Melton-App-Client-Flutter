library constants;

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

//todo verify spellings and alpghabetical order
  static const List<String> campuses = [
    "Accra",
    "Bangalore",
    "Hangzhou",
    "Jena",
    "New Orleans",
    "Temuco",
    "Westmar University",
    "Other"
  ];

}