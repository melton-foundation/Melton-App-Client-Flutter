class UserRegisterResponseModel {
  bool isSuccess;
  bool isUserExists;
  String emailMessage;

  static const SUCCESS = "success";
  static const FAILURE = "failure";
  static const USER_EXISTS_MESSAGE =
      "User with this email address already exists.";
  static const INVALID_EMAIL = "Enter a valid email address.";

  UserRegisterResponseModel(
      {this.isSuccess, this.isUserExists, this.emailMessage});

  factory UserRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterResponseModel(
      isSuccess: checkSuccess(json['type']),
      isUserExists: checkUserExists(json['type'], json['user']),
      emailMessage: getEmailMessage(json['type'], json['user']),
    );
  }

  static bool checkSuccess(String responseType) {
    return responseType == SUCCESS;
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
      return null;
    }
    return false;
  }

  static String getEmailMessage(
      String responseType, Map<String, dynamic> email) {
    if (responseType == FAILURE) {
      if (email != null) {
        return email['email'][0];
      }
    }
    return null;
  }
}
