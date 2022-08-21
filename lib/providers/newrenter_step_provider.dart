import 'package:flutter/cupertino.dart';

class NewRenterStepProvider extends ChangeNotifier {
  String _renterName = '';
  String _phone = '';
  String _phoneAlternate = '';
  String _occupation = '';
  int _noOfMember = 2;

  String? previousAddress;
  String? village;
  String? policeSt;
  String? union;
  String? subDistrict;
  String? district;
  bool _advanceSelected = false;
  double _advanceAmount = 0.00;
  bool get advanceStatus => _advanceSelected;

  set renterName(String name) => _renterName = name;
  set setPhone(int num) => _phone = num.toString().trim();
  set setPhoneAlternate(int num) => _phoneAlternate = num.toString().trim();
  set setOccupation(String occupation) => _occupation = occupation;
  set setMemberNo(int no) => _noOfMember = no;
  set setAdvanceAmount(double amount) => _advanceAmount = amount;

  void setAdvanceStatus(bool value) {
    _advanceSelected = value;
    notifyListeners();
  }

  String get renterName => _renterName;
  String get occupation => _occupation;
  String get memberNo => _noOfMember.toString();
  double get getAdvanceAmount => _advanceAmount;

  GlobalKey<FormState>? firstPageFormKey;

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
}
