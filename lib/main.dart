import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/controllers/shared_pref.dart';
import 'package:sweet_home/models/home_summary.dart';
import 'package:sweet_home/providers/dropdown_provider.dart';
import 'package:sweet_home/providers/new_home_step_provider.dart';
import 'package:sweet_home/providers/newrenter_step_provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/services/auth_service.dart';
import 'package:sweet_home/views/dismiss_keyboard.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/providers/home_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sweet_home/views/wrapper.dart';

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
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        primaryColor: Colors.blue.shade100,
        secondaryHeaderColor: Colors.blue[50],
        appBarTheme: AppBarTheme(
          color: Colors.blue.shade400,
          titleTextStyle: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 18,
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade50,
          ),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.grey.shade900,
            // color: Colors.grey.shade900,
          ),
          subtitle1: TextStyle(
            color: Colors.grey.shade900,
          ),
          headline5: TextStyle(
            color: Colors.grey.shade900,
          ),
          headline6: TextStyle(
            color: Colors.grey.shade900,
          ),
        ),
      ),

      //DARK THEME
      darkTheme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        colorScheme: const ColorScheme.light(),
        primaryColor: Colors.grey.shade800,
        secondaryHeaderColor: Colors.grey.shade700,
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade800,
          titleTextStyle: TextStyle(color: Colors.grey.shade500, fontSize: 18),
          iconTheme: IconThemeData(
            color: Colors.grey.shade500,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,

        //text Theme
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.grey.shade300,
            // color: Colors.grey.shade900,
          ),
          subtitle1: TextStyle(
            color: Colors.grey.shade300,
          ),
          headline5: TextStyle(
            color: Colors.grey.shade300,
          ),
          headline6: TextStyle(
            color: Colors.grey.shade300,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.shade600,
          prefixIconColor: Colors.grey.shade300,
          hintStyle: TextStyle(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      home: const DismissKeyboard(
        child: Wrapper(),
      ),
    );
  }
}
