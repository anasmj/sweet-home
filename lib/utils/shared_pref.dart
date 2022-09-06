import 'package:shared_preferences/shared_preferences.dart';

class SettingPrefence {
  static const String darkModeKey = 'isDarkMode';
  static late SharedPreferences _prefence;

  static Future init() async =>
      _prefence = await SharedPreferences.getInstance();
  static Future setDarkMode(bool isDark) async {
    await _prefence.setBool(darkModeKey, isDark);
  }

  static getDarkMode() => _prefence.getBool(darkModeKey);
}
