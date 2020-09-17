import 'package:flutter/material.dart';

import 'package:melton_app/util/text_util.dart';

class UnknownError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/errors/error_unknown.png"),
        WhiteTitleText(content: "OOPS! SOMETHING WENT WRONG"),
        WhiteSubtitleText(content: "Let us know if this error persists.")
      ],
    );
  }
}
