import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnpttech_pkg/src/vnpttech_sdk_log.dart';

class UserStorage {
  // Them , update user
  Future<void> insert(Map<String, dynamic> item, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString(key, jsonEncode(item));
    printLog("inserted key - $key success: $result");
  }

  // Lay thong tin User
  Future<dynamic> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString(key) as String;
    Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    return userMap;
  }

  // xoa user
  Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
}
