// import 'package:flutter/cupertino.dart';
// import 'package:sweet_home/mvvm/repositories/home_services.dart';
// import 'package:flutter/material.dart';
// import 'package:sweet_home/mvvm/views/app_home_page/app_home_page.dart';
// import 'package:sweet_home/prev/models/home_model.dart';

// import 'waiting_pages/searching_for_home.dart';

// class InitHome extends ChangeNotifier {
//   InitHome() {
//     //TODO: if there there is no home in preference
//     setUserHome();
//   }

//   List<Home> _homeList = [];
//   Home? _home;
//   Home? get home => _home;
//   set setHome(Home home) {
//     _home = home;
//     notifyListeners();
//   }

//   List<Home> get homeList => _homeList;
//   set setHomeList(List<Home> homeList) {
//     _homeList = homeList;
//     notifyListeners();
//   }

//   Widget _displayWidget = const SearchingForHome();
//   get displayWidget => _displayWidget;
//   set setDisplayWidget(Widget display) {
//     _displayWidget = display;
//     notifyListeners();
//   }

//   bool _isLoading = false;
//   get loading => _isLoading;
//   set setLoading(loadingSatus) {
//     _isLoading = loadingSatus;
//     notifyListeners();
//   }

//   Future<void> setUserHome() async {
//     List<Home> homeList = await HomeCrud().getAllHome();
//     if (homeList.isNotEmpty) {
//       setHome = homeList.first;
//     }
//     //set current home
//     setDisplayWidget = const AppHomePage();
//   }
// }
