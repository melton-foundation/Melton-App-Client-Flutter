import 'package:flutter/material.dart';

import 'package:melton_app/screens/posts/posts_home_preview.dart';
import 'package:melton_app/screens/posts/posts_preview_page.dart';
import 'package:melton_app/screens/fellows_map.dart';

import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/util/map_util.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return FellowsMap();
          }));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        Column(
          children: [
            Text("MELTON NEWS", style: TextStyle(
              color: Constants.meltonRed,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
            Expanded(child: PostsHomePreview()),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => PostsPreviewPage()));
              },
              color: Constants.meltonYellow,
              splashColor: Constants.meltonRed,
              child: Text("SEE ALL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            Container(
              child: Image.asset(MapUtil.MELTON_WORLD_MAP_PATH),
            ),
          ],
        ),
      ),
    );
  }
}
