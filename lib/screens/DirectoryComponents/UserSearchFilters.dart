import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melton_app/api/userSearchService.dart';
import 'package:melton_app/screens/DirectoryComponents/UserFilter.dart';

class UserSearchFilters extends StatelessWidget {
  final UserSearchService searchService;

  UserSearchFilters({this.searchService});

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
                Icon(
                  FontAwesomeIcons.filter,
                  color: Colors.white,
                  size: 25,
                ),
                snapshot.data.campusFilter.length > 0
                    ? UserFilter(
                        title: 'Campus',
                        values: snapshot.data.campusFilter,
                        searchService: searchService,
                        alreadySelectedValues: getSelectedValues(snapshot.data.selectedCampusFilterValues, snapshot.data.campusFilter),
                    isFilterSelected: snapshot.data.selectedCampusFilterValues.length !=0,
                      )
                    : Container(),
                snapshot.data.batchYear.length > 0
                    ? UserFilter(
                        title: 'Batch Year',
                        values: snapshot.data.batchYear,
                        searchService: searchService,
                  alreadySelectedValues: getSelectedValues(snapshot.data.selectedBatchYearFilterValues, snapshot.data.batchYear),
                  isFilterSelected: snapshot.data.selectedBatchYearFilterValues.length !=0,
                )
                    : Container(),
                snapshot.data.SDG.length > 0
                    ? UserFilter(
                        title: 'SDG',
                        values: snapshot.data.SDG,
                        searchService: searchService,
                        alreadySelectedValues: getSelectedValues(snapshot.data.selectedSDGFilterValues, snapshot.data.SDG),
                        isFilterSelected: snapshot.data.selectedSDGFilterValues.length != 0,
                      )
                    : Container(),
              ],
            ),
          );
        });
  }

  Set<int> getSelectedValues(
      List<dynamic> selectedValues, Map<int, dynamic> filters) {
    Set<int> alreadySelectedValues = Set<int>();
    if (selectedValues.length == 0 || filters.length == 0)
      return alreadySelectedValues;
    filters.forEach((key, value) {
      if (selectedValues.contains(value)) {
        alreadySelectedValues.add(key);
      }
    });

    return alreadySelectedValues;
  }
}
