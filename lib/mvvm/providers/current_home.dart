import 'package:flutter/cupertino.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';

import '../services/home_services.dart';
import '../views/app_home_page/app_home_page.dart';
import '../views/waiting_pages/searching_indicator.dart';

class CurrentHomeProvider extends ChangeNotifier {
  CurrentHomeProvider() {
    setUserHome();
  }

  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TextEditingController displayTextController = TextEditingController();
  Home? _currentHome;
  Home? get currentHome => _currentHome;

  set setCurrentHome(Home? selectedHome) {
    _currentHome = selectedHome;

    // notifyListeners(); //!it give error
  }

  Widget _displayWidget = const SearchingIndicator();
  get displayWidget => _displayWidget;
  set setDisplayWidget(Widget display) {
    _displayWidget = display;
    notifyListeners();
  }

  Future<void> setUserHome() async {
    List<Home> homeList = await HomeCrud().getAllHome();
    if (homeList.isNotEmpty) {
      setCurrentHome = homeList.first;
    }
    //set current home
    setDisplayWidget = const AppHomePage();
  }
}
