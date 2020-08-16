class ProfileModel {
  String email;
  String name;
  bool isJuniorFellow;
  int points;
  String campus;
  String city;
  int batch;
  String work;
  String phoneNumber;
  Map<String, String> socialMediaAccounts;
  List<int> SDGs;
  String picture;

  //todo constructor
  ProfileModel({this.email, this.name, this.isJuniorFellow, this.points,
  this.campus, this.city, this.batch, this.work, this.phoneNumber,
  this.socialMediaAccounts, this.SDGs, this.picture});

  // todo json decode - handle phone number and social media
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['profile']['email'],
      name: json['profile']['name'],
      isJuniorFellow: json['profile']['isJuniorFellow'],
      points: json['profile']['points'],
      campus: json['profile']['campus'],
      city: json['profile']['city'],
      batch: json['batch'],
      work: json['work'],
      phoneNumber: json['phoneNumber'], //todo
      socialMediaAccounts: json['socialMediaAccounts'], //todo
      SDGs: json['SDGs'],
      picture: json['picture'],
    );
  }
}