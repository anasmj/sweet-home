import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/providers/bills_provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_view_model.dart';
import 'package:sweet_home/prev/providers/home_stepper_provider.dart';
import 'package:sweet_home/prev/providers/newrenter_step_provider.dart';

import 'package:sweet_home/mvvm/repositories/auth_service.dart';
import 'package:sweet_home/mvvm/utils/shared_pref.dart';
import 'package:sweet_home/prev/view/dismiss_keyboard.dart';
import 'package:sweet_home/mvvm/views/resources/app_theme.dart';
import 'package:sweet_home/wrapper.dart';
import 'package:sweet_home/prev/view_models/flat_list_viewmodel.dart';
import 'package:sweet_home/mvvm/view_models/renter_opening_page_view_model.dart';

import 'mvvm/models/transaction_provider.dart';
import 'mvvm/view_models/flat_list_view_model.dart';
import 'mvvm/views/init_home.dart';

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
          create: (context) => SelectedFlatVuewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewRenterStepProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeStepperProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),

        ChangeNotifierProxyProvider<SelectedFlatVuewModel, BillsProvider>(
          update: (context, value, previous) => BillsProvider(
              flatProvider:
                  Provider.of<SelectedFlatVuewModel>(context, listen: false)),
          create: (context) => BillsProvider(
              flatProvider:
                  Provider.of<SelectedFlatVuewModel>(context, listen: false)),
        ),

        ChangeNotifierProvider(
          create: (context) => CurrentHomeProvider(),
        ),
        //*it works
        ChangeNotifierProxyProvider<CurrentHomeProvider, FlatListViewModel>(
            update: (context, currentHomeProvider,
                    FlatListViewModel? viewModel) =>
                FlatListViewModel(currentHome: currentHomeProvider.currentHome),
            create: ((context) => FlatListViewModel())),

        ChangeNotifierProxyProvider2<CurrentHomeProvider, SelectedFlatVuewModel,
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

        //* delete after confirm
        // ChangeNotifierProvider(
        //   create: (context) => FlatListViweModel(),
        // ),
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
