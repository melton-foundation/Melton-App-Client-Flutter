import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorage {

//  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
//  static SharedPreferences _prefsInstance;
  static const String APP_TOKEN_KEY = "appToken";

//  static Future<SharedPreferences> initStorage() async {
//    _prefsInstance = await _instance;
//    return _prefsInstance;
//  }

  static PersistentStorage _storage;
  static SharedPreferences _preferences;


  //todo instantiate once and then call static methods always?
  static Future<PersistentStorage> getInstance() async {
    if (_storage == null) {
      _storage = PersistentStorage();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _storage;
  }

  static void saveStringToStorage(String key, String value) async {
    _preferences.setString(key, value);
    print("saving to persistent storage $key , $value");
  }

  static void removeStringFromStorage(String key) async {
    _preferences.remove(key);
    print('removing from persistent storage $key');
  }

  static Future<String> readStringFromStorage(String key) async {
    return _preferences.getString(key);
  }

}