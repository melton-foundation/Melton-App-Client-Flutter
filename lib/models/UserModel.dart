class UserModel {
  int id;
  String email;
  String name;
  bool isJuniorFellow;
  String campus;
  String city;
  int batch;
  String work;
  String phoneNumber;
  Map<String, String> socialMediaAccounts;
  List<int> SDGs;
  String picture;


//todo constructor
  UserModel({this.id, this.email, this.name, this.isJuniorFellow,
  this.campus, this.city, this.batch, this.work, this.phoneNumber,
  this.socialMediaAccounts, this.SDGs, this.picture});

// todo json decode - handle phone number and social media
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      isJuniorFellow: json['isJuniorFellow'],
      campus: json['campus'],
      city: json['city'],
      batch: json['batch'],
      work: json['work'],
      phoneNumber: json['phoneNumber'], //todo
      socialMediaAccounts: json['socialMediaAccounts'], //todo
      SDGs: json['SDGs'],
      picture: json['picture'],
    );
  }
}