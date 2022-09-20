import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sweet_home/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    bool isDark = context.watch<ThemeProvider>().isDarkMode;

    final SettingsThemeData darkThemeData = SettingsThemeData(
      settingsListBackground: Colors.grey.shade900,
      settingsSectionBackground: Colors.grey.shade800.withOpacity(0.3),
      titleTextColor: Colors.white,
      leadingIconsColor: Colors.white,
      settingsTileTextColor: Colors.white,
      inactiveSubtitleColor: Colors.white,
      tileDescriptionTextColor: Colors.white,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SettingsList(
        lightTheme: isDark ? darkThemeData : const SettingsThemeData(),
        sections: [
          commonSettingSection(theme, isDark),
          accountSection(),
          regionalSection(),
        ],
      ),
    );
  }

  SettingsSection regionalSection() {
    return SettingsSection(
      title: const Text('Regional'),
      tiles: <SettingsTile>[
        SettingsTile.navigation(
          title: const Text('Language'),
          leading: const Icon(Icons.language_rounded),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
          value: const Text('বাংলা'),
        ),
      ],
    );
  }

  SettingsSection accountSection() {
    return SettingsSection(
      title: const Text('Account'),
      tiles: <SettingsTile>[
        SettingsTile.navigation(
          title: const Text('Phone number'),
          leading: const Icon(Icons.phone),
        ),
        SettingsTile.navigation(
          title: const Text('Email'),
          leading: const Icon(Icons.mail),
        ),
        SettingsTile.navigation(
          title: const Text('Password'),
          leading: const Icon(Icons.password_rounded),
        ),
        SettingsTile.navigation(
          title: const Text(
            'Username',
            style: TextStyle(fontSize: 16),
          ),
          leading: const Icon(Icons.person),
        ),
      ],
    );
  }

  SettingsSection commonSettingSection(ThemeProvider theme, bool isDark) {
    return SettingsSection(
      title: const Text('Common Settings'),
      tiles: <SettingsTile>[
        SettingsTile.switchTile(
          onToggle: (value) {
            theme.toogleThemeMode(value);
          },
          initialValue: isDark,
          leading: const Icon(Icons.dark_mode),
          title: const Text('Dark Mode'),
        ),
        SettingsTile.switchTile(
          onToggle: (value) {},
          initialValue: false,
          leading: const Icon(Icons.notifications_active_outlined),
          title: const Text('Notification'),
        ),
        SettingsTile.navigation(
          title: const Text('Font size'),
          leading: const Icon(Icons.format_align_left_sharp),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
        ),
      ],
    );
  }
}
