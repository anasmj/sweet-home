import 'package:flutter/cupertino.dart';

class NewHomeStepProvider extends ChangeNotifier {
  GlobalKey<FormState>? firstPageFormKey;
  GlobalKey<FormState>? secondPageFormKey;

  //FIRST STEP
  int _noOfFloor = 1;
  int _noOfFlat = 1;

  //TEC to be accessed from different places
  TextEditingController homeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController electricityController = TextEditingController();
  TextEditingController gasController = TextEditingController();
  TextEditingController waterController = TextEditingController();

  get floorLength => _noOfFloor;
  get flatLength => _noOfFlat;

  //floor counter
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

  //flat counter
  void increaseFlat() {
    if (_noOfFlat < 6) {
      _noOfFlat += 1;

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
  // bool _advanceSelected = false;
  // double _advanceAmount = 0.00;
}
