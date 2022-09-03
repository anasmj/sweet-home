import 'package:flutter/cupertino.dart';

class HomeSummary extends ChangeNotifier {
  String? homeId;
  String? homeName;
  HomeSummary({this.homeId, this.homeName});
  HomeSummary? _selectedHome;
  static HomeSummary fromJson(Map<String, dynamic> json) => HomeSummary(
        homeId: json['Home Id'],
        homeName: json['Home Name'],
      );

  //for dropdown

  String? _currentHomeName;
  void updateHomeName(String newValue) {
    _currentHomeName = newValue;
    notifyListeners();
  }

  get currentHome => _currentHomeName;
  set setCurrentHome(String name) => _currentHomeName = name;
}
