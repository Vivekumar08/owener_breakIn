import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences prefs;
  String key = 'preference';

  static Future<Preferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return Preferences();
  }

  Future<void> setPreference(bool value) async =>
      await prefs.setBool(key, value);

  bool? getPreference() => prefs.getBool(key);
}
