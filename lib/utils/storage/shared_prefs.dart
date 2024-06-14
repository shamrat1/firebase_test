import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  //for set value
  static Future<bool> setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs!.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs!.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> getBool(String key) async =>
      _prefs!.getBool(key) ?? false;

  static Future<double> getDouble(String key) async =>
      _prefs!.getDouble(key) ?? 0.0;

  static Future<int> getInt(String key) async => _prefs!.getInt(key) ?? 0;

  static Future<String> getString(String key) async =>
      _prefs!.getString(key) ?? "";
}
