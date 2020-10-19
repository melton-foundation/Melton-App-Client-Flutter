import 'package:flutter/material.dart';
import 'package:melton_app/models/UserModel.dart';

import 'package:melton_app/screens/DirectoryComponents/UserTile.dart';

class UserTilesGrid extends StatelessWidget {
  final AsyncSnapshot<List<UserModel>> snapshot;
  final BuildContext context;
  UserTilesGrid({@required this.context, @required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return GridView.count(
      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
      childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
      children: List.generate(snapshot.data.length, (index) {
        return UserTile(
            context: context, snapshot: snapshot, index: index);
      }),
    );
  }
}
