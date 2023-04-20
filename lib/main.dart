import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/view_models/home_service_charge_view_model.dart';
import 'package:sweet_home/mvvm/view_models/home_stepper_view_model.dart';
import 'package:sweet_home/mvvm/view_models/add_renter_view_model.dart';
import 'package:sweet_home/mvvm/services/auth_service.dart';
import 'package:sweet_home/mvvm/utils/shared_pref.dart';
import 'package:sweet_home/mvvm/view_models/record_view_model.dart';
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

        ChangeNotifierProxyProvider2<CurrentHomeProvider, SelectedFlatProvider,
                FlatListViewModel>(
            update: (context, currentHomeProvider, selectedFlat,
                    FlatListViewModel? viewModel) =>
                FlatListViewModel(
                  currentHome: currentHomeProvider.currentHome,
                  selectedFlatProvider: selectedFlat,
                ),
            create: ((context) => FlatListViewModel())),
        ChangeNotifierProxyProvider2<CurrentHomeProvider, SelectedFlatProvider,
                RecordViewModel>(
            update: (context, currentHomeProvider, selectedFlatProvider,
                    RecordViewModel? viewModel) =>
                RecordViewModel(
                  home: currentHomeProvider.currentHome,
                  flat: selectedFlatProvider.selectedFlat,
                ),
            create: ((context) => RecordViewModel())),
        ChangeNotifierProxyProvider<CurrentHomeProvider,
            HomeServiceChargeListViewModel>(
          update: (context, currentHomeProvider, viewModel) =>
              HomeServiceChargeListViewModel(
                  currentHomeProvider: currentHomeProvider),
          create: (context) => HomeServiceChargeListViewModel(),
        ),
        ChangeNotifierProxyProvider3<SelectedFlatProvider, CurrentHomeProvider,
            HomeServiceChargeListViewModel, FlatViewModel>(
          update: (context, flatProvider, homeProvider, serviceChargeViewModel,
              viewModel) {
            return FlatViewModel(
                selectedFlat: flatProvider.selectedFlat,
                currentHomeProvider: homeProvider,
                homeServiceChargeListViewModel: serviceChargeViewModel);
          },
          create: (context) {
            return FlatViewModel();
          },
        ),

        ChangeNotifierProxyProvider<CurrentHomeProvider, HomeListViewModel>(
          update:
              (context, currentHomeProvider, HomeListViewModel? viewModel) =>
                  HomeListViewModel(currentHomeProvider: currentHomeProvider),
          create: (context) => HomeListViewModel(),
        ),

        ChangeNotifierProxyProvider<SelectedFlatProvider, AddRenterViewModel>(
          update: (context, flatProvider, viewModel) => AddRenterViewModel(
              selectedFlatProvider: flatProvider,
              selectedFlatName: flatProvider.selectedFlat?.flatName),
          create: (context) => AddRenterViewModel(
            selectedFlatProvider:
                Provider.of<SelectedFlatProvider>(context, listen: false),
            // selectedFlatName:
            //     context.watch<SelectedFlatProvider>().selectedFlat?.flatName,
          ),
        ),

        ChangeNotifierProvider(
          create: (context) => HomeStepperProviderViewModel(),
        ),

        // ChangeNotifierProxyProvider2<CurrentHomeProvider, SelectedFlatProvider,
        //         UserTransactionListViewModel>(
        //     update: (context, currentHomeProvider, selectedFlat,
        //             UserTransactionListViewModel? viewModel) =>
        //         UserTransactionListViewModel(
        //           currentHome: currentHomeProvider.currentHome,
        //           selectedFlatProvider: selectedFlat,
        //         ),
        //     create: ((context) => UserTransactionListViewModel())),

        ChangeNotifierProxyProvider2<CurrentHomeProvider, FlatViewModel,
            RenterViewModel>(
          update: (context, currentHome, flatViewModel, prevRenterOpeningVM) =>
              RenterViewModel(
                  currentHomeProvider: currentHome,
                  flatViewModel: flatViewModel),
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

void remake() {}
