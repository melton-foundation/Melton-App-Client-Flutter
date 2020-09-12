import 'package:flutter/material.dart';
import 'package:melton_app/api/userSearchService.dart';

class UserSearch extends StatefulWidget {
  final UserSearchService searchService;
  UserSearch({@required this.searchService});
  @override
  _UserSearchState createState() => _UserSearchState(searchService: searchService);
}

class _UserSearchState extends State<UserSearch> {
  UserSearchService searchService;
  _UserSearchState({@required this.searchService});
  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: SizedBox(
          height: 45,
          child: TextField(
            onChanged: (value) {
              /*TODO : show loading or some indicator when user is typing */
              if (value.length > 2) {
                searchService.searchUser(value);
              } else if (value.length == 0) {
                searchService.searchUser(" ");
              }
            },
            onEditingComplete: () => {searchService.searchUser(" ")},
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              height: 1.0,
              fontSize: 20,
            ),
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  searchService.searchUser(" ");
                },
                icon: Icon(Icons.clear),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(40.0),
                ),
              ),
              filled: true,
//              hintStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
//              hintText: "Type in user name",
              fillColor: Colors.white,
            ),
          ),
        )
    );
  }
}
