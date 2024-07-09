import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

///Encapsulate package [Prefs]
///
///To make Simple the use o few calls
class Prefs {
  ///Fetch a [bool] from instance
  static Future<bool> getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key) ?? false;
  }

  ///Insert/update a [bool] on instance
  static void setBool(String key, bool b) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, b);
  }

  ///Fetch a [int] from instance
  static Future<int> getInt(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 0;
  }

  ///Insert/update a [int] on instance
  static void setInt(String key, int i) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, i);
  }

  ///Fetch a [string] from instance
  static Future<String?> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }

  ///Insert/update a [string] on instance
  static Future<void> setString(String key, String s) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(key, s);
  }
}
