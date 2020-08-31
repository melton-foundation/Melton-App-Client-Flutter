import 'package:melton_app/util/persistent_storage.dart';

class TokenHandler {
  String token;
  static const String APP_TOKEN_KEY = "appToken";

  Future<void> refresh(PersistentStorage storage) async {
    token = await storage.readStringFromStorage(APP_TOKEN_KEY);
  }

  String getToken() {
    return "Token " + token;
  }

}