import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  late SharedPreferences prefs;

  Future<void> saveData(String key, dynamic value) async {
    prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  dynamic getData(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
