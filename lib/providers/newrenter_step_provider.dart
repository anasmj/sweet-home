import 'package:flutter/cupertino.dart';

class NewRenterStepProvider extends ChangeNotifier {
  GlobalKey<FormState>? firstPageFormKey;

  //FIRST STEP
  String _renterName = '';
  String _phone = '';
  String _phoneAlternate = '';
  String _occupation = '';
  int _noOfMember = 2;

  set renterName(String name) => _renterName = name;
  set setPhone(int num) => _phone = num.toString().trim();
  set setPhoneAlternate(int num) => _phoneAlternate = num.toString().trim();
  set setOccupation(String occupation) => _occupation = occupation;
  set setMemberNo(int no) => _noOfMember = no;

  String get renterName => _renterName;
  String get occupation => _occupation;
  String get memberNo => _noOfMember.toString();

  void incrementMember() {
    _noOfMember += 1;
    notifyListeners();
  }

  void decrementMember() {
    if (_noOfMember > 1) {
      _noOfMember -= 1;
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

  set setAdvanceAmount(double amount) => _advanceAmount = amount;
  double get getAdvanceAmount => _advanceAmount;

  bool get advanceStatus => _advanceSelected;
  void setAdvanceStatus(bool value) {
    _advanceSelected = value;
    notifyListeners();
  }

  int? selectedFlatNo;
}
