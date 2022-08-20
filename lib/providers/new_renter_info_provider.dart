import 'package:flutter/cupertino.dart';

class NewRenterInfoProvider extends ChangeNotifier {
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
