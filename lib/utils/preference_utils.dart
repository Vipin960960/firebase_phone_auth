import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async => _prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> init() async {
    _prefs = await _instance;
    return _prefs;
  }

  static String getString(String key, [String? defValue]) {
    return _prefs!.getString(key) ?? defValue ?? "";
  }

  static bool containsKey(
    String key,
  ) {
    return _prefs!.containsKey(key);
  }

  static setString(String key, String value) async {
    return _prefs?.setString(key, value);
  }

  static bool getBool(String key) {
    return _prefs!.getBool(key) ?? false;
  }

  static setBool(String key, bool value) async {
    return _prefs!.setBool(key, value);
  }

  static double? getDouble(String key) {
    return _prefs!.getDouble(key);
  }

  static setDouble(String key, double value) async {
    return _prefs!.setDouble(key, value);
  }

  static clear() async {
    for (String key in _prefs!.getKeys()) {
        _prefs!.remove(key);
    }
  }
}
