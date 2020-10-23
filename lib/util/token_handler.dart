import 'package:melton_app/util/persistent_storage.dart';

class TokenHandler {
  String token;
  static const String APP_TOKEN_KEY = "appToken";
  static const String APPLE_EMAIL_KEY = "appleEmail";

  Future<void> refresh(PersistentStorage storage) async {
    token = await storage.readStringFromStorage(APP_TOKEN_KEY);
    if (token == null) {
      token = "token_not_saved_fallback";
    }
  }

  String getToken() {
    return "Token " + token;
  }

}