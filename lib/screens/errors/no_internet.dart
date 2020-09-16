import 'package:flutter/material.dart';

import 'package:melton_app/util/text_util.dart';

class NoInternet extends StatelessWidget {
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/errors/error_no_internet.png"),
            BlackTitleText(content: "NO INTERNET"),
            BlackSubtitleText(content: ""),
            BlackSubtitleText(content: "Or our server is down..."),
          ],
        ),
      ),
    );
  }
}
