import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorage {
  static SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveStringToStorage(String key, String value) async {
    _preferences.setString(key, value);
    print("saving to persistent storage $key , $value");
  }

  Future<void> removeStringFromStorage(String key) async {
    _preferences.remove(key);
    print('removing from persistent storage $key');
  }

  Future<String> readStringFromStorage(String key) async {
    return _preferences.getString(key);
  }
}
