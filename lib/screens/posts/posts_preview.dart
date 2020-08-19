import 'package:flutter/material.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/PostModel.dart';

class PostsPreview extends StatefulWidget {

  @override
  _PostsPreviewState createState() => _PostsPreviewState();
}

class _PostsPreviewState extends State<PostsPreview> {
  Future<List<PostModel>> _model = ApiService().getPostPreviewList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<PostModel>>(future: _model, builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return ListView.builder(itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Text("${snapshot.data[index].title}"),
                Text("${snapshot.data[index].description}"),
                Row(
                  children: [
                    Text("${snapshot.data[index].created}"),
                    Text("${snapshot.data[index].lastUpdated}"),
                  ],
                ),
                Row(
                  children: [
                    //todo fix
                    Text("${snapshot.data[index].tags}"),
//                    ${snapshot.data[index].tags.map((e) => Container(child: Text(e),)).toList();
                  ],
                ),
              ],
            );
            }
          );
        }
        if (snapshot.hasError) {
          return Text("${snapshot.error}"); //todo handle correctly
        }
        //todo make fun error screen
        return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
      },),
    );
  }
}
