import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melton_app/constants/constants.dart' as Constants;
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/screens/components/user_details_dialog.dart';

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
          child: GestureDetector(
            onTap: (){showUserDetails(snapshot.data[index].id);},
            child: snapshot.data[index].picture == null ?
            AssetImage(Constants.placeholder_avatar) :
            Image.network(snapshot.data[index].picture, fit: BoxFit.fill),
          ),
        );
  }

  GestureDetector userTileFooter(AsyncSnapshot<List<UserModel>> snapshot, int index) {
    return GestureDetector(
          onTap: () {
            showUserDetails(snapshot.data[index].id);
          },
          child: GridTileBar(
            title: Center(
              child: Text(snapshot.data[index].name, style: testStyleForUserName()),
            ),
            backgroundColor: Constants.userTileFooterColor,
          ),
        );
  }

  void showUserDetails(int id) {
//    print('show user profile for $id');
    Future<UserModel> model = ApiService().getUserModelById(id);
    model.then((value) => {print(value.name)}).catchError((error)=>{
      print(error.toString())
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => UserDetails(model)));

  }

  userSearch() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: SizedBox(
        height: 40,
        child: TextField(
          onChanged: (value) {
            if(value.length > 2){
              print('entered val : '+value);
              //add search logic here
            }
          },
          style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
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

  userSearchFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          userFilter('Campus'),
          userFilter('Batch Year'),
          userFilter('SDG'),
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

  stylesForFilters() {
    return TextStyle(
//      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 18,
//      letterSpacing: 1.2,
    );
  }

  userFilter(String title) {
    int _value = 1;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
            color: Colors.red, style: BorderStyle.solid, width: 0.80),
        color: Colors.white,
      ),
      child: SizedBox(
        height: 35,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            focusColor: Colors.grey,
            items: [
              DropdownMenuItem(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("Second"),
                value: 2,
              ),
              DropdownMenuItem(child: Text("Third"), value: 3),
              DropdownMenuItem(child: Text("Fourth"), value: 4)
            ],
            onChanged: (value) {},
            isExpanded: false,
            value: 1,
          ),
        ),
      ),
    );
  }

  testStyleForUserName() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }
}
