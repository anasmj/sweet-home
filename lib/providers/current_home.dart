import 'package:flutter/cupertino.dart';
import 'package:sweet_home/models/home_model.dart';

class CurrentHomeProvider extends ChangeNotifier {
  // String? _currentHomeId;
  // String? _currentHomeName;
  Home? _currentHome;

  TextEditingController displayTextController = TextEditingController();

  Home? get getCurrentHome => _currentHome;
  void setCurrentHome(Home? selectedHome) {
    _currentHome = selectedHome;
  }

  // void updateHomeId(String? newValue) {
  //   _currentHomeId = newValue;
  // }

  // get currentHomeId => _currentHomeId;

  // set setCurrentHomeId(String id) => _currentHomeId = id;
  // get currentHomeName => _currentHomeName;
  // set setCurrentHomeName(String? name) => _currentHomeName = name;

  // void updateHomeName(String newValue) {
  //   _currentHomeName = newValue;
  //   notifyListeners();
  // }

  // void clearProviderFields() {
  //   _currentHomeId = null;
  //   _currentHomeName = null;
  // }
}
