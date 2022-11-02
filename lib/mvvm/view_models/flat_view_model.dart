import 'package:flutter/cupertino.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

class FlatViewModel extends ChangeNotifier {
  FlatViewModel({this.selectedFlat, this.currentHomeId}) {
    if (selectedFlat != null && currentHomeId != null) {
      _userFlat = selectedFlat;
      setUserFlat(selectedFlat!);
      // getFlatInfo(flatName: selectedFlat!.flatName, homeId: currentHomeId!);
    }
  }
  Flat? selectedFlat;
  String? currentHomeId;

  Flat? _userFlat;
  bool _isLoading = false;
  double? _usedUnit;

  TextEditingController previousMeterController = TextEditingController();
  TextEditingController currentMeterController = TextEditingController();
  GlobalKey<FormState> meterReadingKey = GlobalKey();

  TextEditingController displayTextController = TextEditingController();
  GlobalKey<FormState> editFlatFormKey = GlobalKey<FormState>();
  double? _electricBill;

  double _electricityUnitPrice = 1; //TODO: MOVE IT TO HOME PROPERTY
  Status _status = Status.empty;

  Flat? get userFlat => _userFlat;
  void setUserFlat(Flat updatedFlat) {
    _userFlat = updatedFlat;
    setUsedUnit(updatedFlat);
    setElectricBill(updatedFlat);
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  double get unitPrice => _electricityUnitPrice;
  void setUnitPrice(double price) {
    _electricityUnitPrice = price;
  }

  Status get status => _status;
  void setStatus(Status newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  double? get usedUnit => _usedUnit;
  void setUsedUnit(Flat flat) {
    if (flat.presentMeterReading != null && flat.previousMeterReading != null) {
      _usedUnit = flat.presentMeterReading! - flat.previousMeterReading!;
    } else {
      _usedUnit = null;
    }
  }

  double? get electricBill => _electricBill;
  void setElectricBill(Flat flat) {
    if (flat.presentMeterReading != null && flat.previousMeterReading != null) {
      _electricBill =
          flat.presentMeterReading! - flat.previousMeterReading! * 1;
      notifyListeners();
    }
  }

  // void getFlatInfo({required String flatName, required String homeId}) async {
  //   setLoading(true);
  //   Response res =
  //       await FlatService().getSingleFlat(homeId: homeId, flatName: flatName);
  //   if (res.code == 200) {
  //     setUserFlat = res.content;
  //   } else {}
  //   setLoading(false);
  // }
  //update flat
  // void updateFlatInfo() async {
  //   if (currentHomeId == null || selectedFlat == null) return;
  //   setLoading(true);
  //   Response res = await FlatService().getSingleFlat(
  //       homeId: currentHomeId!, flatName: selectedFlat!.flatName);
  //   if (res.code == 200) {
  //     setUserFlat(res.content);
  //   } else {}
  //   setLoading(false);
  // }

  Future<void> updateField({
    required String fieldName,
    required dynamic newValue,
  }) async {
    setLoading(true);
    setStatus(Status.loading);
    Response updateResponse = await FlatService().updateFlat(
      homeId: currentHomeId!,
      flatName: selectedFlat!.flatName,
      fieldName: fieldName,
      newValue: newValue,
      updateTime: DateTime.now(),
    );
    Response fetchResonse = await FlatService().getSingleFlat(
        homeId: currentHomeId!, flatName: selectedFlat!.flatName);

    if (updateResponse.code == 200 && fetchResonse.code == 200) {
      setUserFlat(fetchResonse.content);
      setStatus(Status.completed);
    } else {
      setStatus(Status.error);
    }
    setLoading(false);
  }
}
