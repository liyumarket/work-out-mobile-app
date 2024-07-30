import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance = SharedPreferencesService();
  static SharedPreferences? _preferences;

  // Singleton instance
  static Future<SharedPreferencesService> getInstance() async {
    // ignore: unnecessary_null_comparison
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  // Method to get a value from SharedPreferences
  dynamic getValue(String key) {
    return _preferences!.get(key);
  }

  // Method to set a value in SharedPreferences
  Future<bool> setValue(String key, dynamic value) async {
    if (value is bool) {
      return await _preferences!.setBool(key, value);
    } else if (value is int) {
      return await _preferences!.setInt(key, value);
    } else if (value is double) {
      return await _preferences!.setDouble(key, value);
    } else if (value is String) {
      return await _preferences!.setString(key, value);
    } else if (value is List<String>) {
      return await _preferences!.setStringList(key, value);
    }
    return false;
  }

  // Method to remove a value from SharedPreferences
  Future<bool> removeValue(String key) async {
    return await _preferences!.remove(key);
  }
}
