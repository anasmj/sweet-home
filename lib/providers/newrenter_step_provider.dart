import 'package:flutter/cupertino.dart';

class NewRenterStepProvider extends ChangeNotifier {
  GlobalKey<FormState>? firstPageFormKey;

  //FIRST STEP
  // String _renterName = '';
  // String _phone = '';
  // String _phoneAlternate = '';
  TextEditingController renterNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController altPhoneController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController noOfMemberController = TextEditingController();
  TextEditingController nIdController = TextEditingController();
  String _occupation = '';
  int _noOfMember = 2;

  // set renterName(String name) => _renterName = name;
  // set setPhone(int num) => _phone = num.toString().trim();
  // set setPhoneAlternate(int num) => _phoneAlternate = num.toString().trim();
  setOccupation(String occupation) {
    _occupation = occupation;
  }

  set setMemberNo(int no) => _noOfMember = no;

  // String get getRenterName => _renterName;
  String get occupation => _occupation;
  int get memberNo => _noOfMember;

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
  // String? previousAddress;
  // String? village;
  // String? policeSt;
  // String? union;
  // String? subDistrict;
  // String? district;
  TextEditingController previousLocationController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController unionController = TextEditingController();
  TextEditingController thanaController = TextEditingController();
  TextEditingController subDistrictController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  bool isThanaSelected = true;
  void tooglRadio(bool value) {
    isThanaSelected = value;
    notifyListeners();
  }

  //THIRD STEP

  double _unitConsumed = 0;
  get unitConsumed => _unitConsumed;
  set setUnitConsumed(double newUnit) {
    _unitConsumed = newUnit;
    notifyListeners();
  }

  bool _advanceSelected = false;
  // double _advanceAmount = 0.00;
  TextEditingController advanceController = TextEditingController();

  // set setAdvanceAmount(double amount) => _advanceAmount = amount;
  // double get getAdvanceAmount => _advanceAmount;
  DateTime _entryDate = DateTime.now();
  DateTime get entryDate => _entryDate;
  set setEntryDate(DateTime newDateTime) => _entryDate = newDateTime;

  bool get advanceStatus => _advanceSelected;
  void setAdvanceStatus(bool value) {
    _advanceSelected = value;
    notifyListeners();
  }

  int? _selectedFlatNo;
  get selectedFlatNo => _selectedFlatNo;
  void setSelectedFlatNo(int? value) {
    _selectedFlatNo = value;
    notifyListeners();
  }
}
