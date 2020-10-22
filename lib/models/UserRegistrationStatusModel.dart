class UserRegistrationStatusModel {
  bool isApproved;
  String appToken;

  UserRegistrationStatusModel({this.isApproved, this.appToken});

  factory UserRegistrationStatusModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationStatusModel(
        isApproved: json['isApproved'], appToken: json['appToken']);
  }
}
