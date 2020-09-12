import 'package:flutter/material.dart';
import 'package:melton_app/api/userSearchService.dart';

class UserSearch extends StatefulWidget {
  final UserSearchService searchService;
  final ValueChanged<bool> setLoadingStatus;

  UserSearch({@required this.searchService, this.setLoadingStatus});

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  var _controller = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.length > 0;
      });
    });
  }

  Widget _getClearButton() {
    if (!_showClearButton) {
      return null;
    }

    return IconButton(
      onPressed: () {
        _controller.clear();
        FocusScope.of(context).unfocus();
        widget.searchService.searchUser("");
      },
      icon: Icon(Icons.clear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: SizedBox(
          height: 45,
          child: TextField(
            onChanged: (value) {
              /*TODO : show loading or some indicator when user is typing */
              if (value.length > 2) {
                widget.searchService.searchUser(value);
//                widget.setLoadingStatus(true);

              } else if (value.length == 0) {
                widget.searchService.searchUser(" ");
//                widget.setLoadingStatus(true);
              }
            },
            onEditingComplete: () => {widget.searchService.searchUser(" ")},
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              height: 1.0,
              fontSize: 20,
            ),
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: _getClearButton(),
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
