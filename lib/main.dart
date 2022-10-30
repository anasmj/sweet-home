import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/view_models/home_service_charge_view_model.dart';
import 'package:sweet_home/mvvm/view_models/home_stepper_view_model.dart';
import 'package:sweet_home/mvvm/view_models/new_renter_view_model.dart';
import 'package:sweet_home/mvvm/services/auth_service.dart';
import 'package:sweet_home/mvvm/utils/shared_pref.dart';
import 'package:sweet_home/prev/view/dismiss_keyboard.dart';
import 'package:sweet_home/mvvm/views/resources/app_theme.dart';
import 'package:sweet_home/wrapper.dart';
import 'package:sweet_home/mvvm/view_models/renter_view_model.dart';
import 'mvvm/view_models/flat_list_view_model.dart';
import 'mvvm/view_models/home_list_view_model.dart';

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
          create: (context) => CurrentHomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedFlatProvider(),
        ),
        ChangeNotifierProxyProvider<SelectedFlatProvider, NewRenterViewModel>(
          update: (context, flatProvider, viewModel) => NewRenterViewModel(
              selectedFlatProvider: flatProvider,
              selectedFlatName: flatProvider.selectedFlat?.flatName),
          create: (context) => NewRenterViewModel(
            selectedFlatProvider:
                Provider.of<SelectedFlatProvider>(context, listen: false),
            // selectedFlatName:
            //     context.watch<SelectedFlatProvider>().selectedFlat?.flatName,
          ),
        ),
        ChangeNotifierProxyProvider2<SelectedFlatProvider, CurrentHomeProvider,
            FlatViewModel>(
          update: (context, flatProvider, homeProvider, viewModel) =>
              FlatViewModel(
                  selectedFlat: flatProvider.selectedFlat,
                  currentHomeId: homeProvider.currentHome?.homeId),
          create: (context) => FlatViewModel(
            currentHomeId:
                context.read<CurrentHomeProvider>().currentHome?.homeId,
            selectedFlat:
                Provider.of<SelectedFlatProvider>(context, listen: false)
                    .selectedFlat,
          ),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => NewRenterViewModel(),
        // ),
        ChangeNotifierProvider(
          create: (context) => HomeStepperProviderViewModel(),
        ),

        ChangeNotifierProxyProvider2<CurrentHomeProvider, SelectedFlatProvider,
                FlatListViewModel>(
            update: (context, currentHomeProvider, selectedFlat,
                    FlatListViewModel? viewModel) =>
                FlatListViewModel(
                  currentHome: currentHomeProvider.currentHome,
                  selectedFlatProvider: selectedFlat,
                ),
            create: ((context) => FlatListViewModel())),
        // ChangeNotifierProxyProvider2<CurrentHomeProvider, SelectedFlatProvider,
        //         UserTransactionListViewModel>(
        //     update: (context, currentHomeProvider, selectedFlat,
        //             UserTransactionListViewModel? viewModel) =>
        //         UserTransactionListViewModel(
        //           currentHome: currentHomeProvider.currentHome,
        //           selectedFlatProvider: selectedFlat,
        //         ),
        //     create: ((context) => UserTransactionListViewModel())),

        ChangeNotifierProxyProvider2<CurrentHomeProvider, FlatListViewModel,
            HomeServiceChargeListViewModel>(
          update: (context, currentHomeProvider, FlatListViewModel? flatListVM,
                  HomeServiceChargeListViewModel? viewModel) =>
              HomeServiceChargeListViewModel(
                  homeProvider: currentHomeProvider, flatListVM: flatListVM),
          create: (context) => HomeServiceChargeListViewModel(),
        ),

        ChangeNotifierProxyProvider<CurrentHomeProvider, HomeListViewModel>(
          update:
              (context, currentHomeProvider, HomeListViewModel? viewModel) =>
                  HomeListViewModel(currentHomeProvider: currentHomeProvider),
          create: (context) => HomeListViewModel(),
        ),

        ChangeNotifierProxyProvider2<CurrentHomeProvider, SelectedFlatProvider,
            RenterViewModel>(
          update: (context, currentHome, currentFlat, prevRenterOpeningVM) =>
              RenterViewModel(
                  currentHomeProvider: currentHome,
                  selectedFlatProvider: currentFlat),
          create: (context) => RenterViewModel(),
        ),

        // ChangeNotifierProxyProvider<SelectedFlatProvider,
        //     RenterOpeningViewModel>(
        //   update: (context, currentFlat, prevRenterOpeningVM) =>
        //       RenterOpeningViewModel(currentFlat),
        //   create: (context) => RenterOpeningViewModel(null),
        //

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

      ///to dissmiss keyboard when outsite of keyboard is
      ///touched
      home: const DismissKeyboard(
        //User Authentication
        child: Wrapper(),
      ),
    );
  }
}
