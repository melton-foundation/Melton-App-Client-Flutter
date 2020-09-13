import 'package:flutter/material.dart';
import 'package:melton_app/api/userSearchService.dart';
import 'package:melton_app/models/UserModel.dart';

import 'UserTilesGrid.dart';

class UserSearchStreamBuilder extends StatelessWidget {
  final UserSearchService searchService;
  final bool showLoading;
  UserSearchStreamBuilder({@required this.searchService, @required this.showLoading});

  @override
  Widget build(BuildContext context) {
//    bool isPageLoaded == false;
    return Expanded(
        child: getResults(),
    );
  }

  Widget getResults(){
    if(showLoading) {
      searchService.searchUser(" ");
      return Center(child: CircularProgressIndicator());
    }
    else{
      return buildStreamBuilder();
    }
  }

  StreamBuilder<List<UserModel>> buildStreamBuilder() {
    return StreamBuilder<List<UserModel>>(
        stream: searchService.results,
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}"); //todo handle correctly
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                searchService.searchUser(" ");
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Center(child: Text("No results found"));
                  } else {
                    return UserTilesGrid(context: context, snapshot: snapshot);
                  }
                } else {
                  return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
                }
//              case ConnectionState.done
            }
          }
          return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
        });
  }
}
