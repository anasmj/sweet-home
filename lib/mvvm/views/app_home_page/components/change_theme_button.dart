import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
        value: context.watch<ThemeProvider>().isDarkMode,
        onChanged: ((value) {
          context.read<ThemeProvider>().toogleThemeMode(value);
        }));
  }
}
