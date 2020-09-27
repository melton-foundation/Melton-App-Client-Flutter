class StoreModel {
  int id;
  String name;
  String image;
  String description;
  int points;
  bool active;
  bool purchased;

  StoreModel({this.id, this.name, this.image, this.description, this.points, this.active,
      this.purchased});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(id: json['id'], name: json['name'], image: json['previewImage'],
    description: json['description'], points: json['points'],
    active: json['active'], purchased: json['purchased']);
  }

}

class StoreItemBuy {
  int availablePoints;

  StoreItemBuy({this.availablePoints});

  factory StoreItemBuy.fromJson(Map<String, dynamic> json) {
    return StoreItemBuy(availablePoints: json['details']['availablePoints']);
  }

}