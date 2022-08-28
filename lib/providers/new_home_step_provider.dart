import 'package:flutter/cupertino.dart';

class NewHomeStepProvider extends ChangeNotifier {
  GlobalKey<FormState>? firstPageFormKey;

  //FIRST STEP
  String _homeName = '';
  String _address = '';
  int _noOfFloor = 1;
  int _noOfFlat = 1;

  set homeName(String name) => _homeName = name;
  String get name => _homeName;

  set homeAddress(String add) => _address = add;
  String get homeAdress => _address;

  get floorLength => _noOfFloor;
  get flatLength => _noOfFlat;

  void increaseFloor() {
    if (_noOfFloor < 9) {
      _noOfFloor += 1;

      notifyListeners();
    }
  }

  void decreaseFloor() {
    if (_noOfFloor > 1) {
      _noOfFloor -= 1;
      notifyListeners();
    }
  }

  void increaseFlat() {
    if (_noOfFlat < 6) {
      _noOfFlat += 1;
      ;
      notifyListeners();
    }
  }

  void decreaseFlat() {
    if (_noOfFlat > 1) {
      _noOfFlat -= 1;

      notifyListeners();
    }
  }

  //SECOND STEP
  String? previousAddress;
  String? village;
  String? policeSt;
  String? union;
  String? subDistrict;
  String? district;

  //THIRD STEP
  bool _advanceSelected = false;
  double _advanceAmount = 0.00;
}
