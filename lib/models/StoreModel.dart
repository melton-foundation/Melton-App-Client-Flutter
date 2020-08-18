class StoreModel {
  int id;
  String name;
  String description;
  int points;
  bool active;
  bool purchased;

  StoreModel({this.id, this.name, this.description, this.points, this.active,
      this.purchased});

  factory StoreModel.fromJson(Map<String, dynamic> json) {

  }

}