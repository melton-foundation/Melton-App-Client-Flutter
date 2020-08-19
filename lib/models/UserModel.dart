import 'package:melton_app/models/ProfileModel.dart';

class UserModel {
  int id;
  String email;
  String name;
  bool isJuniorFellow;
  String campus;
  String city;
  int batch;
  String work;
  PhoneNumber phoneNumber;
  SocialMediaAccounts socialMediaAccounts;
  List<int> SDGs;
  String picture;

  UserModel({this.id, this.email, this.name, this.isJuniorFellow,
  this.campus, this.city, this.batch, this.work, this.phoneNumber,
  this.socialMediaAccounts, this.SDGs, this.picture});

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
      phoneNumber: PhoneNumber.fromJson(json['phoneNumber']),
      socialMediaAccounts: SocialMediaAccounts.fromJson(new List<dynamic>.from(json['socialMediaAccounts'])),
      SDGs: json['SDGs'],
      picture: json['picture'],
    );
  }
}