import 'package:flutter/material.dart';
import 'package:melton_app/api/userSearchService.dart';
import 'package:melton_app/screens/DirectoryComponents/MultiSelectDialog.dart';

class UserFilter extends StatefulWidget {
  final String title;
  bool isFilterSelected;
  final values;
  Set<int> alreadySelectedValues = Set<int>();
  final UserSearchService searchService;

  UserFilter(
      {Key key,
      @required this.title,
      @required this.values,
      this.alreadySelectedValues,
      @required this.searchService,
      this.isFilterSelected = false})
      : super(key: key);

  @override
  _UserFilterState createState() => _UserFilterState();
}

class _UserFilterState extends State<UserFilter> {
  @override
  Widget build(BuildContext context) {
    List<MultiSelectItem<int>> multiItem = List();

    void populateMultiSelectValues() {
      for (int v in widget.values.keys) {
        multiItem.add(MultiSelectItem(v, widget.values[v]));
      }
    }

    List<dynamic> clearSelectedFilterValues() {
      List<dynamic> filterSet;
      if (widget.title.toLowerCase().contains('campus')) {
        filterSet =
            widget.searchService.filterOptions.selectedCampusFilterValues;
      } else if (widget.title.toLowerCase().contains('sdg')) {
        filterSet = widget.searchService.filterOptions.selectedSDGFilterValues;
      } else {
        filterSet =
            widget.searchService.filterOptions.selectedBatchYearFilterValues;
      }
      filterSet.clear();
      return filterSet;
    }

    void _showFiltersAlertBox(BuildContext context) async {
      multiItem = [];
      populateMultiSelectValues();
      final items = multiItem;
      void updateSelectedFilterValues(Set selection) {
        List<dynamic> filterSet = clearSelectedFilterValues();
        for (int index in selection.toList()) {
          filterSet.add(widget.values[index]);
          print(widget.values[index]);
        }
      }

      final selectedFilterValues = await showDialog<Set<int>>(
        context: context,
        builder: (BuildContext context) {
          return MultiSelectDialog(
            title: widget.title,
            items: items,
            initialSelectedValues: widget.alreadySelectedValues,
          );
        },
      );
      if (selectedFilterValues != null) {
        bool isFilterSelected = false;
        if (selectedFilterValues.isNotEmpty) {
          isFilterSelected = true;
          widget.alreadySelectedValues = selectedFilterValues.toSet();
          updateSelectedFilterValues(selectedFilterValues);
        } else {
          clearSelectedFilterValues();
          widget.alreadySelectedValues.clear();
        }
        widget.searchService.applyFiltersOnAvailableResults();
        setState(() {
          widget.isFilterSelected = isFilterSelected;
        });
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: FilterChip(
        label: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        selected: widget.isFilterSelected,
        onSelected: (bool value) {
          _showFiltersAlertBox(context);
        },
      ),
    );
  }
}
