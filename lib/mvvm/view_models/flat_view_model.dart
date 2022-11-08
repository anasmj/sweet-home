import 'package:flutter/cupertino.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/service_charges.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/view_models/home_service_charge_view_model.dart';

class FlatViewModel extends ChangeNotifier {
  FlatViewModel(
      {this.selectedFlat,
      this.currentHomeProvider,
      this.homeServiceChargeListViewModel}) {
    if (selectedFlat != null && currentHomeProvider != null) {
      _userFlat = selectedFlat;
      setUserFlat(selectedFlat!);
      // getFlatInfo(flatName: selectedFlat!.flatName, homeId: currentHomeId!);
    }
  }
  CurrentHomeProvider? currentHomeProvider;
  HomeServiceChargeListViewModel? homeServiceChargeListViewModel;
  Flat? selectedFlat;
  bool _isLoading = false;
  Flat? _userFlat;

  double? _usedUnit;
  double? _electricBill;
  double? _utilityBill;

  double? _total;
  double? _grandTotal;
  double? _monthlyDue;

  TextEditingController previousMeterController = TextEditingController();
  TextEditingController currentMeterController = TextEditingController();

  GlobalKey<FormState> meterReadingKey = GlobalKey();
  TextEditingController displayTextController = TextEditingController();
  GlobalKey<FormState> editFlatFormKey = GlobalKey<FormState>();

  double _electricityUnitPrice = 1; //TODO: MOVE IT TO HOME PROPERTY
  Status _status = Status.empty;
  Flat? get userFlat => _userFlat;

  bool get isLoading => _isLoading;
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  double? _meterReading;

  Status get status => _status;
  void setStatus(Status newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  void setUserFlat(Flat updatedFlat) {
    _userFlat = updatedFlat;
    setUsedUnit(updatedFlat);
    setElectricBill(updatedFlat);
    setUtilityBill();
    setTotal();
    setGrandTotal();
    notifyListeners();
  }

  double? get meterReading => _meterReading;
  set setMeterReading(double value) {
    _meterReading = value;
  }

  double get unitPrice => _electricityUnitPrice;
  void setUnitPrice(double price) {
    _electricityUnitPrice = price;
  }

  double? get total => _total;
  void setTotal() {
    double? rent = _userFlat?.flatRentAmount;
    double? gas = _userFlat?.flatGasBill;
    double? water = _userFlat?.flatWaterBill;
    double? electricBill = _electricBill;
    double? utility = _utilityBill;
    if (rent != null &&
        gas != null &&
        water != null &&
        electricBill != null &&
        utility != null) {
      _total = rent + gas + water + electricBill + utility;
    } else {
      _total = null;
    }
  }

  double? get grandTotal => _grandTotal;
  void setGrandTotal() {
    if (_total != null) {
      if (_userFlat != null) {
        if (userFlat!.renter != null) {
          _grandTotal = _total! + _userFlat!.renter!.dueAmount;
        }
      }
    }
  }

  double? get monthlyDue => _monthlyDue;
  void setMonthlyDue() {
    double? due = _userFlat?.monthlyDue;
    if (due != null && _grandTotal != null) {
      _monthlyDue = due - _grandTotal!;

      notifyListeners();
    }
  }

  double? get utilityBill => _utilityBill;
  void setUtilityBill() {
    if (homeServiceChargeListViewModel == null) return;
    double sum = 0;

    if (!homeServiceChargeListViewModel!.isLoading) {
      List<Utility>? serviceChargeList =
          homeServiceChargeListViewModel?.serviceChargeList;
      if (serviceChargeList!.isNotEmpty) {
        for (var utility in serviceChargeList) {
          sum += utility.amount;
        }
      }
    }
    _utilityBill = sum;
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

  Future<bool> updateField({
    required String fieldName,
    required dynamic newValue,
    DateTime? updateTime,
  }) async {
    bool status = false;
    String? currentHomeId = currentHomeProvider?.currentHome?.homeId;
    if (currentHomeId == null) return false;

    setLoading(true);
    setStatus(Status.loading);
    Response updateResponse = await FlatService().updateFlat(
      homeId: currentHomeId,
      flatName: selectedFlat!.flatName,
      fieldName: fieldName,
      newValue: newValue,
      updateTime: updateTime,
    );
    Response fetchResonse = await FlatService()
        .getSingleFlat(homeId: currentHomeId, flatName: selectedFlat!.flatName);

    if (updateResponse.code == 200 && fetchResonse.code == 200) {
      status = true;
      setUserFlat(fetchResonse.content);
      setStatus(Status.completed);
    } else {
      setStatus(Status.error);
    }
    setLoading(false);
    return status;
  }

  Future<void> updateFlat() async {
    // setLoading(true);
    String? homeId = currentHomeProvider?.currentHome?.homeId;
    if (homeId == null || _userFlat == null) return;
    Response res = await FlatService()
        .getSingleFlat(homeId: homeId, flatName: _userFlat!.flatName);
    if (res.content is Flat) {
      setUserFlat(res.content);
    } else {
      setStatus(Status.error);
    }
    // setLoading(false);
  }

  Future<bool> confirmMonthlyExpence() async {
    if (total == 0) return false;

    bool status = await updateField(
        fieldName: 'monthlyDue', newValue: _total, updateTime: DateTime.now());
    return status;
  }
}
