import 'package:flutter/cupertino.dart';
import 'package:sweet_home/prev/models/home_model.dart';

import '../repositories/home_services.dart';
import '../views/app_home_page/app_home_page.dart';
import '../views/waiting_pages/searching_for_home.dart';

class CurrentHomeProvider extends ChangeNotifier {
  CurrentHomeProvider() {
    setUserHome();
    print('in constructor');
  }
  List<Home> _homeList = [];

  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TextEditingController displayTextController = TextEditingController();
  Home? _currentHome;
  Home? get currentHome => _currentHome;

  set setCurrentHome(Home? selectedHome) {
    _currentHome = selectedHome;

    // notifyListeners(); //!it give error
  }

  Widget _displayWidget = const SearchingForHome();
  get displayWidget => _displayWidget;
  set setDisplayWidget(Widget display) {
    _displayWidget = display;
    notifyListeners();
  }

  // set setHome(Home home) {
  //   _currentHome = home;
  //   print('new home set');
  //   notifyListeners();
  // }

  Future<void> setUserHome() async {
    print('in set home method');
    List<Home> homeList = await HomeCrud().getAllHome();
    if (homeList.isNotEmpty) {
      setCurrentHome = homeList.first;
    }
    //set current home
    setDisplayWidget = const AppHomePage();
  }
}
