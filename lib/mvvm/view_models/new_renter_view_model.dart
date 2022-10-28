import 'package:flutter/cupertino.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/transaction.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/renter_service.dart';
import 'package:sweet_home/mvvm/services/transaction_service.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

class NewRenterViewModel extends ChangeNotifier {
  NewRenterViewModel({this.selectedFlatProvider, this.selectedFlatName});

  SelectedFlatProvider? selectedFlatProvider;
  String? selectedFlatName;
  Response response = Response();

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
  final List<String> occupationOptions = ['চাকরিজীবি', 'ব্যাবসায়ী', 'অন্যান্য'];
  DataStatus _dataStatus = DataStatus.loading;
  DataStatus get status => _dataStatus;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  void setDataStatus(DataStatus status) {
    _dataStatus = status;
    notifyListeners();
  }

  DateTime get entryDate => _renterEntryDate;
  void setEntryDate(DateTime newDateTime) {
    _renterEntryDate = newDateTime;

    notifyListeners();
  }

  bool isThanaSelected = true;
  int _noOfMember = 2;
  String _occupation = '';

  String get occupation => _occupation;
  setOccupation({String? occupation}) {
    _occupation = occupation ?? 'চাকরিজীবি';
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

  Future<Response> addTransactionToRenter(
      {required String homeId, required RenterTransaction transaction}) async {
    if (selectedFlatName != null) {
      setLoading(true);
      response = await TransactionService().addTransactionToRenter(
          homeId: homeId, flatId: selectedFlatName!, transaction: transaction);
      setLoading(false);
    } else {
      response.code = 201;
      response.body = 'no flat found';
    }
    return response;
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
      renterNameController.clear();
      phoneController.clear();
      altPhoneController.clear();
      setOccupation();
      setMemberNo = 2;
      nIdController.clear();
      previousLocationController.clear();
      villageController.clear();
      thanaController.clear();
      unionController.clear();
      subDistrictController.clear();
      districtController.clear();
      advanceController.clear();
      setEntryDate(DateTime.now());
      setDataStatus(DataStatus.completed);
    }
  }
}
