import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  SharedPreferences? prefs;

  Future<void> initializePrefsIfNull() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool?> setInt(String key, int value) async {
    await initializePrefsIfNull();
    return prefs?.setInt(key, value);
  }

  Future<bool?> setBool(String key, bool value) async {
    await initializePrefsIfNull();
    return prefs?.setBool(key, value);
  }

  Future<bool?> setDouble(String key, double value) async {
    await initializePrefsIfNull();
    return prefs?.setDouble(key, value);
  }

  Future<bool?> setString(String key, String value) async {
    await initializePrefsIfNull();
    return prefs?.setString(key, value);
  }

  Future<bool?> setStringList(String key, List<String> value) async {
    await initializePrefsIfNull();
    return prefs?.setStringList(key, value);
  }

  Future<int?> getInt(String key) async {
    await initializePrefsIfNull();
    return prefs?.getInt(key);
  }

  Future<bool?> getBool(String key) async {
    await initializePrefsIfNull();
    return prefs?.getBool(key);
  }

  Future<double?> getDouble(String key) async {
    await initializePrefsIfNull();
    return prefs?.getDouble(key);
  }

  Future<String?> getString(String key) async {
    await initializePrefsIfNull();
    return prefs?.getString(key);
  }

  Future<List<String>?> getStringList(String key) async {
    await initializePrefsIfNull();
    return prefs?.getStringList(key);
  }

  Future<void> delete(String key) async {
    await initializePrefsIfNull();
    await prefs?.remove(key);
  }

  Future<void> clear() async {
    await prefs?.clear();
  }
}
