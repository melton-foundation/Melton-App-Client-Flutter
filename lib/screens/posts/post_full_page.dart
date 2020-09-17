import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:melton_app/api/api.dart';
import 'package:melton_app/util/get_human_time.dart';
import 'package:melton_app/models/PostModel.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PostFullPage extends StatefulWidget {
  final int postId;

  PostFullPage({this.postId});

  @override
  _PostFullPageState createState() => _PostFullPageState();
}

class _PostFullPageState extends State<PostFullPage> {
  Future<PostModel> _model;

  @override
  Widget build(BuildContext context) {
    //todo test and replace all screens with singleton ApiService
    _model = GetIt.instance.get<ApiService>().getPostById(widget.postId);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text("Melton News")),
        body: Container(
              child: FutureBuilder<PostModel>(
                future: _model,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            children: [
                              snapshot.data.previewImage == null ? Container() :
                              Image(
                                image: NetworkImage(snapshot.data.previewImage),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.title,
                                  style: TextStyle(
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
                                      snapshot.data.lastUpdated == null ?
                                      "Created " + GetHumanTime.getHumanTime(snapshot.data.created) :
                                      "Updated " + GetHumanTime.getHumanTime(snapshot.data.lastUpdated),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.description,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                height: 800,
                                child: Markdown(
                                  data: snapshot.data.content,
                                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                                      .copyWith(textScaleFactor: 1.2),
                                  onTapLink: (url) {
                                    _launch(url);
                                  },
                                  )
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}"); //todo handle correctly
                  }
                  //todo make fun error screen
                  return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
                },
              ),
            ),
//          ],
//        )
    );
  }
}

_launch(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    print("could not launch $url");
  }
}
