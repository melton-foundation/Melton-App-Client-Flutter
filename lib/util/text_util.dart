import 'package:flutter/material.dart';

class WhiteTitleText extends StatelessWidget {
  final String content;

  WhiteTitleText({this.content});

  @override
  Widget build(BuildContext context) {
    return Text(content,
      style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),
    );
  }
}

class WhiteSubtitleText extends StatelessWidget {
  final String content;

  WhiteSubtitleText({this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Text(content,
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}

class BlackTitleText extends StatelessWidget {
  final String content;

  BlackTitleText({this.content});

  @override
  Widget build(BuildContext context) {
    return Text(content,
      style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
    );
  }
}

class BlackSubtitleText extends StatelessWidget {
  final String content;

  BlackSubtitleText({this.content});

  @override
  Widget build(BuildContext context) {
    return Text(content,
      style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
    );
  }
}

class BlackSubSubtitleText extends StatelessWidget {
  final String content;

  BlackSubSubtitleText({this.content});

  @override
  Widget build(BuildContext context) {
    return Text(content,
      style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
    );
  }
}