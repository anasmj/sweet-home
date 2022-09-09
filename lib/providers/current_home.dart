import 'package:flutter/cupertino.dart';

class CurrentHomeProvider extends ChangeNotifier {
  String? _currentHomeId;
  String? _currentHomeName;
  bool _ishomeDeleted = false;

  void updateHomeId(String? newValue) {
    _currentHomeId = newValue;
  }

  get currentHomeId => _currentHomeId;
  // set setCurrentHomeId(String id) => _currentHomeId = id;
  get currentHomeName => _currentHomeName;
  set setCurrentHomeName(String name) => _currentHomeName = name;
  get isHomeDeleted => _ishomeDeleted;

  void updateHomeName(String newValue) {
    _currentHomeName = newValue;
    notifyListeners();
  }

  homeDeleted(bool isDeleted) {
    _ishomeDeleted = isDeleted;
    notifyListeners();
    _ishomeDeleted = !isDeleted; //set to false again
  }
}
