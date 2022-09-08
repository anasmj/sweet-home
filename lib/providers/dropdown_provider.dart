import 'package:flutter/cupertino.dart';

class DropdownProvider extends ChangeNotifier {
  String? _currentHomeId;
  String? _currentHomeName;
  void updateHomeId(String? newValue) {
    _currentHomeId = newValue;
    notifyListeners();
  }

  get currentHomeId => _currentHomeId;
  // set setCurrentHomeId(String id) => _currentHomeId = id;
  get currentHomeName => _currentHomeName;
  set setCurrentHomeName(String name) => _currentHomeName = name;

  void updateHomeName(String newValue) {
    _currentHomeName = newValue;
    notifyListeners();
  }

  void clearDropdownValues() {
    _currentHomeId = null;
    _currentHomeName = null;
  }
}
