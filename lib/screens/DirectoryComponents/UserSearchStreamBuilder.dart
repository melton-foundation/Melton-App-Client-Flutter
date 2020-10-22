import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:melton_app/api/userSearchService.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/screens/errors/unknown_error.dart';
import 'package:melton_app/sentry/CustomExceptions/CustomExceptions.dart';
import 'package:melton_app/sentry/SentryService.dart';
import 'package:melton_app/util/text_util.dart';

import 'UserTilesGrid.dart';

class UserSearchStreamBuilder extends StatelessWidget {
  final UserSearchService searchService;
  UserSearchStreamBuilder({@required this.searchService});

  @override
  Widget build(BuildContext context) {
//    bool isPageLoaded == false;
    return Expanded(
      child: buildStreamBuilder(),
    );
  }

  StreamBuilder<List<UserModel>> buildStreamBuilder() {
    return StreamBuilder<List<UserModel>>(
        stream: searchService.results,
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.hasError) {
            GetIt.instance.get<SentryService>().reportErrorToSentry(
                error: UserSearchStreamBuilderException(
                    "User Search StreamBuilder : ${snapshot.error}"));
            //todo test and add everywhere
            return Column(
              children: [
                UnknownError(),
                Text("${snapshot.error}"),
              ],
            ); //todo handle correctly
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
              case ConnectionState.done:
                searchService.searchUser(" ");
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ));
              case ConnectionState.active:
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Center(
                        child: Column(
                      children: [
                        Image.asset("assets/errors/error_no_results.png"),
                        WhiteTitleText(content: "NO RESULTS FOUND!"),
                      ],
                    ));
                  } else {
                    return UserTilesGrid(context: context, snapshot: snapshot);
                  }
                } else {
                  return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
                }
            }
          }
          return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
        });
  }
}
