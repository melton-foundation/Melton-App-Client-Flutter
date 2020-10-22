import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/sentry/CustomExceptions/CustomExceptions.dart';
import 'package:melton_app/sentry/SentryService.dart';
import 'package:melton_app/util/get_human_time.dart';
import 'package:melton_app/models/PostModel.dart';

import 'package:melton_app/constants/constants.dart';

class PostsHomePreview extends StatefulWidget {
  @override
  _PostsHomePreviewState createState() => _PostsHomePreviewState();
}

class _PostsHomePreviewState extends State<PostsHomePreview> {
  Future<List<PostModel>> _model = ApiService().getPostPreviewList(true);
  final Widget empty = Container(height: 0, width: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<PostModel>>(
        future: _model,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return snapshot.data.length == 0
                ? empty
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return postPreviewCard(snapshot.data[index]);
                    });
          }
          if (snapshot.hasError) {
            GetIt.instance.get<SentryService>().reportErrorToSentry(
                error: PostsHomePreviewException(
                    "Posts Home Preview : ${snapshot.error}"));
            return Text("${snapshot.error}"); //todo handle correctly
          }
          //todo make fun error screen
          return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
        },
      ),
    );
  }
}

Widget postPreviewCard(PostModel postModel) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Constants.meltonBlue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
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
        ],
      ),
    ),
  );
}
