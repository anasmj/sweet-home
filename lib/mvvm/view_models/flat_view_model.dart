import 'package:flutter/cupertino.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';

class FlatViewModel extends ChangeNotifier {
  FlatViewModel({this.selectedFlat, this.currentHomeId}) {
    if (selectedFlat != null && currentHomeId != null) {
      getFlatInfo(flat: selectedFlat!, homeId: currentHomeId!);
    }
  }
  Flat? selectedFlat;
  String? currentHomeId;
  Flat? flat;

  Flat? _userFlat;
  bool _isLoading = false;
  double? _usedUnit;

  double? _electricBill;
  double _electricityUnitPrice = 1; //TODO: MOVE IT TO HOME PROPERTY

  Flat? get userFlat => _userFlat;
  set setUserFlat(Flat updatedFlat) {
    _userFlat = updatedFlat;
    setUsedUnit(updatedFlat);
    setElectricBill(updatedFlat);
  }

  bool get isLoading => _isLoading;
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  double get unitPrice => _electricityUnitPrice;
  void setUnitPrice(double price) {
    _electricityUnitPrice = price;
    notifyListeners();
  }

  double? get usedUnit => _usedUnit;
  void setUsedUnit(Flat flat) {
    if (flat.currentMeterReading != null && flat.previousMeterReading != null) {
      _usedUnit = flat.currentMeterReading! - flat.previousMeterReading!;
      notifyListeners();
    }
  }

  double? get electricBill => _electricBill;
  void setElectricBill(Flat flat) {
    if (flat.currentMeterReading != null && flat.previousMeterReading != null) {
      _electricBill =
          flat.currentMeterReading! - flat.previousMeterReading! * 1;
      notifyListeners();
    }
  }

  void getFlatInfo({required Flat flat, required String homeId}) async {
    setLoading(true);
    Response res = await FlatService()
        .getSingleFlat(homeId: homeId, flatName: flat.flatName);
    if (res.code == 200) {
      setUserFlat = res.content;
    } else {}
    setLoading(false);
  }
}
