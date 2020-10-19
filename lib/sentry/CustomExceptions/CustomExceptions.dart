class CustomException implements Exception {
  String error;
  CustomException([String error = 'Error occurred']) {
    this.error = error;
  }
  @override
  String toString() {
    return error;
  }
}

class PostFullPageException extends CustomException {
  PostFullPageException(error) : super(error);
}
class StoresException extends CustomException {
  StoresException(error) : super(error);
}
class PostsHomePreviewException extends CustomException {
  PostsHomePreviewException(error) : super(error);
}
class PostsPreviewException extends CustomException {
  PostsPreviewException(error) : super(error);
}
class ProfilesException extends CustomException {
  ProfilesException(error) : super(error);
}
class UserSearchStreamBuilderException extends CustomException {
  UserSearchStreamBuilderException(error) : super(error);
}
class UserDetailsException extends CustomException {
  UserDetailsException(error) : super(error);
}
class UserRegisterException extends CustomException {
  UserRegisterException(error) : super(error);
}