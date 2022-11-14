import 'package:flutter/cupertino.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/record.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/utility.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/services/record_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/fields.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
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
  List<Utility> utilityList = [];

  GlobalKey<FormState> meterReadingKey = GlobalKey();
  TextEditingController displayTextController = TextEditingController();
  GlobalKey<FormState> editFlatFormKey = GlobalKey<FormState>();

  double _electricityUnitPrice = 1; //TODO: MOVE IT TO HOME PROPERTY
  Status _status = Status.empty;
  Flat? get userFlat => _userFlat;

  DateTime prevMonthDate = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  Record? _monthRecord;

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
    double rent = _userFlat?.flatRentAmount ?? 0;
    double gas = _userFlat?.flatGasBill ?? 0;
    double water = _userFlat?.flatWaterBill ?? 0;
    double electricBill = _electricBill ?? 0;
    double utility = _utilityBill ?? 0;
    _total = rent + gas + water + electricBill + utility;
  }

  double? get grandTotal => _grandTotal;
  void setGrandTotal() {
    if (_total != null) {
      if (_userFlat != null) {
        if (userFlat!.renter != null) {
          _grandTotal = _total! + _userFlat!.renter!.renterDue;
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
      utilityList = homeServiceChargeListViewModel!.serviceChargeList;
      if (utilityList.isNotEmpty) {
        for (var utility in utilityList) {
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
          flat.presentMeterReading! - flat.previousMeterReading! * unitPrice;
    }
  }

  Record? get record => _monthRecord;
  set setRecord(Record? record) => _monthRecord = record;

  Response? _response;
  Response get response => _response ?? Response();
  setResponse(Response res) {
    _response = res;
  }

  Future<bool> updateFlatField({
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

  Future<bool> confirmMonthlyExpence() async {
    if (electricBill == null) return false;
    // bool isFlatUpdated = await updateFlatField(
    //     fieldName: FlatField.due, newValue: _total, updateTime: DateTime.now());
    bool isFlatUpdated = await FlatService().updateMultiple(
        homeId: currentHomeProvider!.currentHome!.homeId,
        flatName: _userFlat!.flatName,
        map: {
          FlatField.due: _total,
          FlatField.confirmDate: DateTime.now().toIso8601String(),
        });

    // create monthly record

    bool isRecordCreated = await RecordService().createMonthlyRecord(
      monthID: Formatter.makeId(prevMonthDate),
      homeId: currentHomeProvider!.currentHome!.homeId,
      flatId: _userFlat!.flatName,
      issueDate: DateTime.now(),
      record: Record(
        rent: _userFlat!.flatRentAmount,
        renterPhone: _userFlat!.renter!.phone,
        renterPhone2: _userFlat!.renter!.alternatePhoneNo ?? '',
        gasBill: _userFlat!.flatGasBill,
        waterBill: _userFlat!.flatWaterBill,
        presentMeterReading: _userFlat!.presentMeterReading,
        previousMeterReading: _userFlat!.previousMeterReading,
        unitPrice: _electricityUnitPrice,
        electricBill: _electricBill,
        monthlyDue: _total ?? 0,
        renterName: _userFlat!.renter!.renterName,
        total: total,
        grandTotal: _grandTotal,
        utilities: utilityList,
      ),
    );

    return isFlatUpdated && isRecordCreated;

    // if (isFlatUpdated && isRecordCreated) {
    //   Response response = await getLastMonthRecord();
    //   if (response.code == 200) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
    //   return false;
    // }
  }

  Future<Response> getLastMonthRecord() async {
    Response res;
    String? homeId = currentHomeProvider?.currentHome?.homeId;
    String? flatName = _userFlat?.flatName;
    String previousMonthRecordId = Formatter.makeId(DateTime(
        DateTime.now().year, DateTime.now().month - 1, DateTime.now().day));
    res = await RecordService().fetchRecord(
        homeId: homeId!, flatName: flatName!, idMonth: previousMonthRecordId);
    // if (res.code != 200) {
    //   return res;
    // } else {
    //   Record? record = res.content;
    //   if (record == null) {
    //     setRecord = null;
    //   } else {
    //     //record found
    //     setRecord = record;

    //     //record exists but belogns to another renter
    //     res.content = null;
    //   }
    // }
    return res;
  }
}
