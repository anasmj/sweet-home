import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/utils/shared_pref.dart';
import 'package:sweet_home/providers/dropdown_provider.dart';
import 'package:sweet_home/providers/new_home_step_provider.dart';
import 'package:sweet_home/providers/newrenter_step_provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/services/auth_service.dart';
import 'package:sweet_home/view/dismiss_keyboard.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/providers/home_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sweet_home/view/resources/app_theme.dart';
import 'package:sweet_home/view/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SettingPrefence.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentFlatInfoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewRenterStepProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewHomeStepProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DropdownProvider(),
        ),
        ListenableProvider(
          create: (context) => ThemeProvider(),
        ),
        Provider<AuthService>(
          create: (context) => AuthService(),
        ),
      ],
      child: const SweetHome(),
    );
  }
}

class SweetHome extends StatelessWidget {
  const SweetHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweet Home',
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeProvider>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: AppTheme.appLightTheme(),
      darkTheme: AppTheme.appDarkTheme(),
      home: const DismissKeyboard(
        //User Authentication
        child: Wrapper(),
      ),
    );
  }
}
