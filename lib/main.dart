import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/controllers/shared_pref.dart';
import 'package:sweet_home/providers/newrenter_step_provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/views/app_theme.dart';
import 'package:sweet_home/views/steppers/new_renter_stepper/test_firebase/test_purpose.dart';
import 'package:sweet_home/views/dismiss_keyboard.dart';
import 'package:sweet_home/views/home_page/home_page.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/providers/home_provider.dart';
import 'package:firebase_core/firebase_core.dart';

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
        ListenableProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const SweetHome(),
    );
  }
}

class SweetHome extends StatelessWidget {
  const SweetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      //dismiss keyboard with outer touch located anywhere in the app
      child: MaterialApp(
        title: 'Sweet Home',
        debugShowCheckedModeBanner: false,
        themeMode: context.watch<ThemeProvider>().isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light,

        theme: ThemeData(
          secondaryHeaderColor: Colors.blue[100],
          appBarTheme: AppBarTheme(
            color: Colors.blue.shade400,
            titleTextStyle: TextStyle(
              color: Colors.grey.shade50,
            ),
            iconTheme: IconThemeData(
              color: Colors.grey.shade50,
            ),
          ),
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: Colors.grey.shade800,
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: const ColorScheme.light(),
          primaryColor: Colors.grey.shade900,
          secondaryHeaderColor: Colors.grey.shade700,
          appBarTheme: AppBarTheme(
            color: Colors.grey.shade900,
            titleTextStyle: TextStyle(
              color: Colors.grey.shade500,
            ),
            iconTheme: IconThemeData(
              color: Colors.grey.shade500,
            ),
          ),
          scaffoldBackgroundColor: Colors.grey.shade800,

          //text Theme
          textTheme: const TextTheme(
            bodyText2: TextStyle(
              color: Colors.white70,
              // color: Colors.grey.shade900,
            ),
            subtitle1: TextStyle(
              color: Colors.white70,
            ),
            headline5: TextStyle(
              color: Colors.white70,
            ),
            headline6: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),

        home: const HomePage(),
        // home: NewRenterStepper(),
      ),
    );
  }
}
