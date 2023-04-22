part of 'theme.model.dart';

extension ThemeProfileExtension on ThemeProfile {
  ThemeData get theme {
    switch (this) {
      case ThemeProfile.light:
        return lightTheme;
      case ThemeProfile.dark:
        return lightTheme;
    }
  }

  ThemeProfile get toggled =>
      this == ThemeProfile.light ? ThemeProfile.light : ThemeProfile.light;
}
