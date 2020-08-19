import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart' as Constants;
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/UserModel.dart';

class Directory extends StatefulWidget {
  @override
  _DirectoryState createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory> {
  Future<List<UserModel>> _userListModel = ApiService().getUsers();

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: Constants.directoryBackground,
        body: Column(
          children: [
            userSearch(),
            userSearchFilter(),
            Expanded(
              child: FutureBuilder<List<UserModel>>(
                future: _userListModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return buildGridViewForUsersList(orientation, snapshot);
                  }
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}"); //todo handle correctly
                  }
                  //todo make fun error screen
                  return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
                },
//                child: ,
              ),
            ),
          ],
        )
    );
  }

  GridView buildGridViewForUsersList(
      Orientation orientation, AsyncSnapshot<List<UserModel>> snapshot) {
    return GridView.count(
      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      padding: const EdgeInsets.all(15),
      childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
      //todo check this
      children: List.generate(snapshot.data.length, (index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: userTile(snapshot, index),
        );
      }),
    );
  }

  GridTile userTile(AsyncSnapshot<List<UserModel>> snapshot, int index) {
    return GridTile(
          footer: userTileFooter(snapshot, index),
          child: Image.network(
            snapshot.data[index].picture,
            fit: BoxFit.fill,
          ),
        );
  }

  GestureDetector userTileFooter(AsyncSnapshot<List<UserModel>> snapshot, int index) {
    return GestureDetector(
          onTap: () {
            print(
                'show user profile for ${snapshot.data[index].name} || id : ${snapshot.data[index].id}');
          },
          child: GridTileBar(
            title: Center(
              child: Text(snapshot.data[index].name),
            ),
            backgroundColor: Colors.red,
          ),
        );
  }

  userSearch() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Text('User Search Bar', style: stylesForFilters()),
    );
  }

  userSearchFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        userFilter('Campus'),
        userFilter('Batch Year'),
        userFilter('SDG'),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.filter_list,
            color: Colors.white,
            size: 25,
          ),
        ),
      ],
    );
  }

  stylesForFilters() {
    return TextStyle(
//      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 17,
//      letterSpacing: 1.2,
    );
  }

  userFilter(String title) {
    return RaisedButton(
      onPressed: () { print('$title button is pressed'); },
      color: Constants.userSearchFilters,
      child: Text(title, style: stylesForFilters()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
