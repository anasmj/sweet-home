import 'package:flutter/cupertino.dart';
import '../utils/shared_pref.dart';
import '../utils/shared_pref.dart';

class ThemeProvider extends ChangeNotifier {
  //takig from user preference
  bool _isDarkMode = SettingPrefence.getDarkMode() ?? false;

  bool get isDarkMode => _isDarkMode;

  void toogleThemeMode(bool value) {
    _isDarkMode = value;
    SettingPrefence.setDarkMode(_isDarkMode);
    notifyListeners();
  }
}
