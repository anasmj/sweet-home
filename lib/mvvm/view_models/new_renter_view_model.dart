import 'package:flutter/cupertino.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/renter_service.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

class NewRenterViewModel extends ChangeNotifier {
  NewRenterViewModel({this.selectedFlatProvider, this.selectedFlatName});

  SelectedFlatProvider? selectedFlatProvider;
  String? selectedFlatName;

  GlobalKey<FormState>? firstPageFormKey;
  TextEditingController renterNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController altPhoneController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController noOfMemberController = TextEditingController();
  TextEditingController nIdController = TextEditingController();
  TextEditingController previousLocationController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController unionController = TextEditingController();
  TextEditingController thanaController = TextEditingController();
  TextEditingController subDistrictController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  bool _advanceSelected = false;
  DateTime _renterEntryDate = DateTime.now();
  DataStatus _dataStatus = DataStatus.loading;
  DataStatus get status => _dataStatus;
  void setDataStatus(DataStatus status) {
    _dataStatus = status;
    notifyListeners();
  }

  DateTime get entryDate => _renterEntryDate;
  set setEntryDate(DateTime newDateTime) => _renterEntryDate = newDateTime;

  bool isThanaSelected = true;
  int _noOfMember = 2;
  String _occupation = '';

  String get occupation => _occupation;
  setOccupation(String occupation) {
    _occupation = occupation;
  }

  bool get advanceStatus => _advanceSelected;
  void setAdvanceStatus(bool value) {
    _advanceSelected = value;
    notifyListeners();
  }

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

  int get memberNo => _noOfMember;
  set setMemberNo(int no) => _noOfMember = no;

  void tooglRadio(bool value) {
    isThanaSelected = value;
    notifyListeners();
  }

  Future<void> addRenter({required String homeId}) async {
    if (selectedFlatName == null) return;
    Response res = await RenterService().addRenterToFlat(
      //1st page
      homeId: homeId,
      flatId: selectedFlatName!,
      renterName: renterNameController.text,
      phoneNo: phoneController.text,
      alternatePhoneNo: altPhoneController.text,
      occupation: occupation,
      noOfPerson: memberNo,
      nIdNumber: int.tryParse(nIdController.text),
      //2nd page
      previousLocation: previousLocationController.text,
      village: villageController.text,
      policeStation: thanaController.text,
      union: unionController.text,
      subDistrict: subDistrictController.text,
      district: districtController.text,
      //3rd page
      advance: double.tryParse(advanceController.text),
      entryDate: entryDate,
    );
    if (res.code != 200) {
      setDataStatus(DataStatus.error);
    } else {
      setDataStatus(DataStatus.completed);
    }

    // print(
    //     '$renterNameController\n $phoneController $altPhoneController $occupationController $noOfMemberController $nIdController $previousLocationController $villageController $unionController $thanaController $subDistrictController $districtController $advanceController');
    // Response res = await RenterService().addRenterToFlat(

    // );
  }
}

// set renterName(String name) => _renterName = name;
// set setPhone(int num) => _phone = num.toString().trim();
// set setPhoneAlternate(int num) => _phoneAlternate = num.toString().trim();

// String get getRenterName => _renterName;

// double _advanceAmount = 0.00;

// set setAdvanceAmount(double amount) => _advanceAmount = amount;
// double get getAdvanceAmount => _advanceAmount;
