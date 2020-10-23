import 'package:flutter/material.dart';

import 'package:melton_app/api/userSearchService.dart';

import 'package:melton_app/util/text_util.dart';

class UserSearchedString extends StatelessWidget {
  final UserSearchService searchService;

  UserSearchedString({this.searchService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: searchService.searchedString,
      builder: (context, snapshot) {
        if (snapshot.data == null || snapshot.data.trim().length <= 2) {
          return Container();
        }
        return WhiteSubtitleText(
            content: "Showing Fellows with '${snapshot.data}'");
      },
    );
  }
}
