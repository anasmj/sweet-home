import 'package:flutter/cupertino.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/services/home_services.dart';
import 'package:sweet_home/mvvm/views/app_home_page/app_home_page.dart';
import '../views/waiting_pages/searching_indicator.dart';

class CurrentHomeProvider extends ChangeNotifier {
  CurrentHomeProvider() {
    setUserHome();
  }

  // GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  // TextEditingController displayTextController = TextEditingController();
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

  Future<void> setUserHome({List<Home>? userHomes}) async {
    List<Home> homeList = [];
    if (userHomes == null) {
      Response res = await HomeServices().getAllHomeVM();
      if (res.code == 200) {
        homeList = res.content;
        if (homeList.isNotEmpty) {
          setCurrentHome = homeList.first;
        }
      }
    } else {
      if (userHomes.isEmpty) return;
      setCurrentHome = homeList.first;
    }
    //set current home
    setDisplayWidget = const AppHomePage();
  }
  // Future<void> setUserHome({List<Home>? userHomes}) async {
  //   if (userHomes == null) {
  //     List<Home> homeList = await HomeServices().getAllHome();
  //     if (homeList.isNotEmpty) {
  //       setCurrentHome = homeList.first;
  //     }
  //   } else {
  //     setCurrentHome = userHomes.first;
  //   }

  //   //set current home
  //   setDisplayWidget = const AppHomePage();
  // }
}
