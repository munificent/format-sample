// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'percept_flutter_platform_interface.dart';
import 'package:uuid/uuid.dart';

/// A web implementation of the PerceptFlutterPlatform of the PerceptFlutter plugin.
class PerceptFlutterWeb extends PerceptFlutterPlatform {
  /// Constructs a PerceptFlutterWeb
  PerceptFlutterWeb();

  static const String uniqueID = "unique_id";
  static const String userID = "user_id";

  static void registerWith(Registrar registrar) {
    PerceptFlutterPlatform.instance = PerceptFlutterWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }

  @override
  Future<String?> getUniqueID() async {
    var iUniqueId = getLocal(uniqueID);
    if (iUniqueId == null) {
      iUniqueId = "PT-${const Uuid().v4()}";
      saveLocal({uniqueID: iUniqueId});
    }
    return iUniqueId;
  }

  @override
  Future<bool?> setUserId(String userId) async {
    saveLocal({userID: userId});
    return true;
  }

  @override
  Future<String?> getUserId() async {
    return getLocal(userID);
  }

  @override
  Future<bool?> clear() async {
    removeLocal(userID);
    removeLocal(uniqueID);
    return true;
  }

  @override
  Future<Map<String, String>?> getGlobalProperties(
    List<String>? includeProperties,
    List<String>? excludeProperties,
  ) async {
    Map<String, String> globalProperties = {};
    String? uniqueId = await getUniqueID();
    String? userId = await getUserId();
    if (uniqueId != null) {
      globalProperties.putIfAbsent(uniqueID, () => uniqueId);
    }
    if (userId != null) {
      globalProperties.putIfAbsent(userID, () => userId);
    }
    includeProperties?.map((e) => {globalProperties[e] = e});
    excludeProperties?.map((e) => {globalProperties.remove(e)});
    return globalProperties;
  }

  bool isLocalStorageSupported() {
    try {
      bool empty = window.localStorage.isEmpty;
      if (kDebugMode) {
        empty;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  void saveLocal(Map<String, dynamic> data) {
    data.forEach((key, value) {
      if (isLocalStorageSupported()) {
        window.localStorage[key] = value;
      } else {
        document.cookie =
            '$key=$value; expires=Thu, 01 Jan 2099 00:00:00 UTC; path=/';
      }
    });
  }

  String? getLocal(String name) {
    if (isLocalStorageSupported()) {
      return window.localStorage[name];
    } else {
      String? cookie = document.cookie;
      if (cookie != null && cookie.isNotEmpty) {
        List<String> cookies = cookie.split(';');
        for (String cookieValue in cookies) {
          List<String> parts = cookieValue.trim().split('=');
          if (parts[0] == name) {
            return parts[1];
          }
        }
      }
      return null;
    }
  }

  void removeLocal(String name) {
    if (isLocalStorageSupported()) {
      window.localStorage.remove(name);
    } else {
      document.cookie = '$name=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/';
    }
  }
}
