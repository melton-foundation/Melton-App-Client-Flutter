class PostModel {
  int id;
  String title;
  String description;
  String content;
  List<String> tags;
  DateTime created;
  DateTime lastUpdated;

  PostModel({this.id, this.title, this.description, this.content, this.tags, this.created,
      this.lastUpdated});

  factory PostModel.fromJson(Map<String, dynamic> responsePost) {
    return PostModel(id: responsePost['id'], title: responsePost['title'],
      description: responsePost['description'], tags: new List<String>.from(responsePost['tags']),
      content: responsePost['content'],
      created: DateTime.parse(responsePost['created']),
      // lastUpdated is null if post hasn't been updated
      lastUpdated: responsePost['created'].split(".")[0] == responsePost['updated'].split(".")[0] ?
        null : DateTime.parse(responsePost['updated']));
  }
}