import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart';

class SDGProfile extends StatelessWidget {
  static const String SDG_image_path = "assets/UN_SDG/sdg_";
  static const String SDG_image_extension = ".png";
  final int firstSDG;
  final int secondSDG;
  final int thirdSDG;

  SDGProfile({this.firstSDG, this.secondSDG, this.thirdSDG});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.0),
        Divider(),
        Text("SDGs",
          textAlign: TextAlign.left,
          style: TextStyle(letterSpacing: 2.0,
              color: Constants.meltonBlue,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(flex: 1, child: Image.asset(SDG_image_path + firstSDG.toString() + SDG_image_extension)),
            Expanded(flex: 1, child: Image.asset(SDG_image_path + secondSDG.toString() + SDG_image_extension)),
            Expanded(flex: 1, child: Image.asset(SDG_image_path + thirdSDG.toString() + SDG_image_extension)),
          ],
        ),
      ],
    );
  }
}
