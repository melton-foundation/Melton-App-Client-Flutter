import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:melton_app/screens/DirectoryComponents/UserFilter.dart';

class UserSearchFilters extends StatefulWidget {
  @override
  _UserSearchFiltersState createState() => _UserSearchFiltersState();
}

class _UserSearchFiltersState extends State<UserSearchFilters> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          UserFilter(title:'Campus'),
          UserFilter(title:'Batch Year'),
          UserFilter(title:'SDG'),
          IconButton(
            // todo add alert dialog with info about filter that pops up when you click filter icon
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.filter,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
