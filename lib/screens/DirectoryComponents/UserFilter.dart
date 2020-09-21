import 'package:flutter/material.dart';
import 'package:melton_app/api/userSearchService.dart';
import 'package:melton_app/screens/DirectoryComponents/MultiSelectDialog.dart';

class UserFilter extends StatefulWidget {
  final String title;
  bool isFilterSelected = false;
  final values;
  Set<int> alreadySelectedValues = Set<int>();
  final UserSearchService searchService;

  UserFilter(
      {Key key, @required this.title, @required this.values, this.alreadySelectedValues, @required this.searchService})
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

    void _showFiltersAlertBox(BuildContext context) async {
      multiItem = [];
      populateMultiSelectValues();
      final items = multiItem;

      void updateSelectedFilterValues(Set selection) {
        if (selection != null) {
          for (int index in selection.toList()) {
            if(widget.title.contains('campus')){
              widget.searchService.filteredCampuses.add(widget.values[index]);
            }
            else if(widget.title.contains('SDG')){
              widget.searchService.filteredSDGs.add(widget.values[index]);
            }
            else{
              widget.searchService.filteredBatchYear.add(widget.values[index]);
            }
            print(widget.values[index]);
          }
        }
      }

      final selectedFilterValues = await showDialog<Set<int>>(
        context: context,
        builder: (BuildContext context) {
          return MultiSelectDialog(
            title: "Select Checkboxes",
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
        }
        setState(() {
          widget.isFilterSelected = isFilterSelected;
        });
      }
      updateSelectedFilterValues(selectedFilterValues);
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
