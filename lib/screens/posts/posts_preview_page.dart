import 'package:flutter/material.dart';

import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/PostModel.dart';
import 'package:melton_app/util/get_human_time.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melton_app/screens/posts/post_full_page.dart';

import 'package:melton_app/constants/constants.dart' as Constants;

class PostsPreviewPage extends StatefulWidget {
  @override
  _PostsPreviewPageState createState() => _PostsPreviewPageState();
}

class _PostsPreviewPageState extends State<PostsPreviewPage> {
  Future<List<PostModel>> _model = ApiService().getPostPreviewList(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Melton News")),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<List<PostModel>>(
        future: _model,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            //todo make a nice widget for no /posts - like "all caught up!"
            return snapshot.data.length == 0
                ? Container()
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return postPreviewCard(context, snapshot.data[0]);
                    });
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}"); //todo handle correctly
          }
          //todo make fun error screen
          return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
        },
      ),
    );
  }
}

Widget postPreviewCard(BuildContext context, PostModel postModel) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Constants.meltonBlue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          postModel.previewImage == null
              ? Container()
              : Image(
                  image: NetworkImage(postModel.previewImage),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              postModel.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  postModel.lastUpdated == null
                      ? "Created " +
                          GetHumanTime.getHumanTime(postModel.created)
                      : "Updated " +
                          GetHumanTime.getHumanTime(postModel.lastUpdated),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              postModel.description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          postModel.tags.length == 0
              ? Container()
              : Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.tags, color: Colors.white),
                    ),
                    for (String tag in postModel.tags)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Constants.meltonRed,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => PostFullPage(postId: postModel.id)));
            },
            color: Constants.meltonYellow,
            splashColor: Constants.meltonRed,
            child: Text(
              "READ MORE",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
