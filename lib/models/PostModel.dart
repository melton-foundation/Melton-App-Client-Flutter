class PostModel {
  int id;
  String title;
  String description;
  List<String> tags;
  DateTime created;
  DateTime lastUpdated;

  PostModel({this.id, this.title, this.description, this.tags, this.created,
      this.lastUpdated});

  factory PostModel.fromJson(Map<String, dynamic> responsePost) {
    return PostModel(id: responsePost['id'], title: responsePost['title'],
      description: responsePost['description'], tags: new List<String>.from(responsePost['tags']),
      created: DateTime.parse(responsePost['created']), lastUpdated: DateTime.parse(responsePost['updated']));
  }
}