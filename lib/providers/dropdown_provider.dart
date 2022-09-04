import 'package:flutter/cupertino.dart';

class DropdownProvider extends ChangeNotifier {
  //tracking current home id
  String? _currentHomeId;
  void updateHomeId(String? newValue) {
    _currentHomeId = newValue;
    // notifyListeners();
  }

  get currentHomeId => _currentHomeId;
  set setCurrentHomeId(String id) => _currentHomeId = id;

  //for dropdown values
  String? _currentHomeName;
  void updateHomeName(String newValue) {
    _currentHomeName = newValue;
    notifyListeners();
  }

  get currentHomeName => _currentHomeName;
  set setCurrentHomeName(String name) => _currentHomeName = name;
}
