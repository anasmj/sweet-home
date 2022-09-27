import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/bills_provider.dart';
import 'package:sweet_home/providers/monthly_record_provider.dart';
import 'package:sweet_home/utils/shared_pref.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/providers/home_stepper_provider.dart';
import 'package:sweet_home/providers/newrenter_step_provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/services/auth_service.dart';
import 'package:sweet_home/view/dismiss_keyboard.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/providers/home_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:sweet_home/view/resources/app_theme.dart';
import 'package:sweet_home/view/wrapper.dart';
import 'package:sweet_home/view_models/flat_list_viewmodel.dart';
import 'package:sweet_home/view_models/renter_opening_page_view_model.dart';

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
        // ChangeNotifierProvider(
        //   create: (context) => HomeProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => SelectedFlatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewRenterStepProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeStepperProvider(),
        ),

        ChangeNotifierProxyProvider<SelectedFlatProvider, BillsProvider>(
          update: (context, value, previous) => BillsProvider(
              flatProvider:
                  Provider.of<SelectedFlatProvider>(context, listen: false)),
          create: (context) => BillsProvider(
              flatProvider:
                  Provider.of<SelectedFlatProvider>(context, listen: false)),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentHomeProvider(),
        ),
        // ChangeNotifierProxyProvider<CurrentHomeProvider, FlatListViweModel>(
        //   create: (BuildContext context) => FlatListViweModel(),
        //   update: (BuildContext context, currentHome, viewModel) =>
        //       FlatListViweModel(),
        // ),
        ChangeNotifierProxyProvider2<CurrentHomeProvider, SelectedFlatProvider,
            RenterOpeningViewModel>(
          update: (context, currentHome, currentFlat, prevRenterOpeningVM) =>
              RenterOpeningViewModel(
                  currentHomeProvider: currentHome,
                  selectedFlatProvider: currentFlat),
          create: (context) => RenterOpeningViewModel(),
        ),

        // ChangeNotifierProxyProvider<SelectedFlatProvider,
        //     RenterOpeningViewModel>(
        //   update: (context, currentFlat, prevRenterOpeningVM) =>
        //       RenterOpeningViewModel(currentFlat),
        //   create: (context) => RenterOpeningViewModel(null),
        // ),

        ChangeNotifierProvider(
          create: (context) => FlatListViweModel(),
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

      ///dissmiss keyboard is a custom class
      ///to dissmiss keyboard when outsite of keyboard is
      ///touched
      home: const DismissKeyboard(
        //User Authentication
        child: Wrapper(),
      ),
    );
  }
}
