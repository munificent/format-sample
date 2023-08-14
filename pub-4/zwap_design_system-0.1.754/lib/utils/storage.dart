/// IMPORTING THIRD PARTY PACKAGES
import 'package:shared_preferences/shared_preferences.dart';

class ZwapStorage {

  ZwapStorage._();

  static final ZwapStorage _instance = ZwapStorage._();

  factory ZwapStorage() {
    return _instance;
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// It retrieves a string value from the localStorage. It returns an empty string if this value is not present
  Future<String> getString(String key) async {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString(key) ?? "";
    });
  }

  /// It puts the string value inside the localStorage
  void putString(String key, String value) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString(key, value);
    });
  }

  /// It removes a value from the localStorage
  void removeValue(String key) async{
    _prefs.then((SharedPreferences prefs) {
      prefs.remove(key);
    });
  }

  /// It retrieves a bool value from the localStorage. It returns a false value if this value is not present
  Future<bool> getBool(String key) async {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(key) ?? false;
    });
  }

  /// It puts a bool value inside the localStorage
  Future<bool> putBool(String key, bool value) async {
    return _prefs.then((SharedPreferences prefs) {
      prefs.setBool(key, value);
      return true;
    });
  }
}