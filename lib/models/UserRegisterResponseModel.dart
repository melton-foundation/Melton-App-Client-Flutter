class UserRegisterResponseModel {

  bool isUserExists;
  String appToken;
  String emailMessage;

  static const SUCCESS = "success";
  static const FAILURE = "failure";
  static const USER_EXISTS_MESSAGE = "User with this email address already exists.";
  static const INVALID_EMAIL = "Enter a valid email address.";

  UserRegisterResponseModel({this.isUserExists, this.appToken, this.emailMessage});

  factory UserRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterResponseModel(
      appToken: validateToken(json['type'], json['appToken']),
      isUserExists: checkUserExists(json['type'], json['user']),
      emailMessage: getEmailMessage(json['type'], json['user']),
    );
  }

  static String validateToken(String responseType, String responseToken) {
    if (responseType == SUCCESS) {
      return responseToken;
    } else {
      return null;
    }
  }

  static bool checkUserExists(String responseType, Map<String, dynamic> email) {
    if (responseType == FAILURE) {
      if (email != null) {
        if (email['email'][0] == USER_EXISTS_MESSAGE) {
          return true;
        }
        if (email['email'][0] == INVALID_EMAIL) {
          return false;
        }
      }
      //todo handle upstream?
      return null;
    }
    return false;
  }

  static String getEmailMessage(String responseType, Map<String, dynamic> email) {
    if (responseType == FAILURE) {
      if (email != null) {
        return email['email'][0];
      }
    }
    return null;
  }
}