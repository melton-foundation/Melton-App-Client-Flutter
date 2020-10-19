import 'package:flutter/material.dart';
import 'package:melton_app/Notification/NotificationBuilder.dart';
import 'package:melton_app/api/userSearchService.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/screens/DirectoryComponents/UserSearch.dart';
import 'package:melton_app/screens/DirectoryComponents/UserSearchFilters.dart';
import 'package:melton_app/screens/DirectoryComponents/UserSearchedString.dart';
import 'package:melton_app/screens/DirectoryComponents/UserSearchStreamBuilder.dart';

class Directory extends StatefulWidget {
  @override
  _DirectoryState createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory> {
  final UserSearchService searchService = new UserSearchService();   // make this singleton

  @override
  void initState() {
    NotificationBuilder builder = NotificationBuilder();
    builder.init();
    super.initState();
  }

  void dispose(){
    /*TODO : check whether dispose is placed in correct place or not*/
    print('dispose directory');
    searchService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.directoryBackground,
      body: Column(
        children: [
          UserSearch(searchService: searchService),
          UserSearchFilters(searchService: searchService),
          UserSearchedString(searchService: searchService),
          UserSearchStreamBuilder(searchService: searchService),
        ],
      )
    );
  }
}
