import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melton_app/api/userSearchService.dart';
import 'package:melton_app/constants/constants.dart';

import 'package:melton_app/screens/DirectoryComponents/UserFilter.dart';

class UserSearchFilters extends StatelessWidget {
  final UserSearchService searchService;

  UserSearchFilters({this.searchService});

  final campus = {1: "RVCE", 2: "BMS", 3: "BOSTON", 4: "Harvard"};
  final batch = {1: "1996", 2: "2001", 3: "2002", 4: "2018"};
  final SDG = {1: "one", 2: "two", 3: "three", 4: "four"};

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: searchService.filters,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                snapshot.data.campusFilter.length > 0
                    ? UserFilter(title: 'Campus', values: snapshot.data.campusFilter, searchService: searchService)
                    : Container(),
                snapshot.data.batchYear.length > 0
                    ? UserFilter(title: 'Batch Year', values: snapshot.data.batchYear, searchService: searchService)
                    : Container(),
                UserFilter(title: 'SDG', values: Constants.SDGs, searchService: searchService),
                Icon(
                  FontAwesomeIcons.filter,
                  color: Colors.white,
                  size: 25,
                ),
              ],
            ),
          );
        });
  }
}
