import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key key,
    @required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 18.0,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundImage: url == null
              ? AssetImage(Constants.placeholder_avatar)
              : NetworkImage(url),
          radius: 50.0,
        ),
      ),
    );
  }
}