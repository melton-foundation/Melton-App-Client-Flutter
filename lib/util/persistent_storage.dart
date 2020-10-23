import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorage {
  static SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveStringToStorage(String key, String value) async {
    _preferences.setString(key, value);
  }

  Future<void> removeStringFromStorage(String key) async {
    _preferences.remove(key);
  }

  Future<String> readStringFromStorage(String key) async {
    return _preferences.getString(key);
  }
}
