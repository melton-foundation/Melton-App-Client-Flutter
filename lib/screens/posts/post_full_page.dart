import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:melton_app/api/api.dart';
import 'package:melton_app/constants/constants.dart';

import 'package:melton_app/util/get_human_time.dart';
import 'package:melton_app/util/url_launch_util.dart';

import 'package:melton_app/models/PostModel.dart';

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
      body: Container(
        child: FutureBuilder<PostModel>(
          future: _model,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return _buildMarkdownPost(snapshot);
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}"); //todo handle correctly
            }
            //todo make fun error screen
            return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
          },
        ),
      ),
    );
  }

  Widget _buildMarkdownPost(AsyncSnapshot<PostModel> snapshot) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Melton News"),
            floating: true,
            expandedHeight: snapshot.data.previewImage == null ? null : 300,
            flexibleSpace: snapshot.data.previewImage == null
                ? null
                : FlexibleSpaceBar(
                    background: _getPostPreview(snapshot.data.previewImage),
                  ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _getPostTitle(snapshot.data.title),
              _getUpdatedTime(snapshot),
              _getPostDescription(snapshot.data.description),
              _getDivider(),
              _getMarkdownPost(snapshot.data.content),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _getPostTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _getPostPreview(String previewImage) {
    return Container(
      child: Image(
        image: NetworkImage(previewImage),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _getPostDescription(String description) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        description,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _getDivider() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(
        indent: width / 4,
        endIndent: width / 4,
        color: Constants.meltonBlueAccent,
      ),
    );
  }

  Widget _getUpdatedTime(AsyncSnapshot<PostModel> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            snapshot.data.lastUpdated == null
                ? "Created " + GetHumanTime.getHumanTime(snapshot.data.created)
                : "Updated " +
                    GetHumanTime.getHumanTime(snapshot.data.lastUpdated),
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMarkdownPost(String content) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: MarkdownBody(
        data: content,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
            .copyWith(textScaleFactor: 1.2),
        onTapLink: (url) {
          launchUrlWebview(url);
        },
      ),
    );
  }
}
