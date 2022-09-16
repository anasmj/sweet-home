import 'package:flutter/cupertino.dart';

import '../models/flat_model.dart';
import '../models/others_model.dart';
import '../models/renter.dart';

///CONSUMED BY MonthDetails Object
///PROVIDES INFORMATION RAELATED TO RENTER OF FLAT CLICKED BY USER.
///VALUES WILL BE TAKEN TO CREATE NEW MonthDetail
///OBJECT; IF THERE ARE ALREADY VALUE IN MONTH DETAILS THEN
///DO NOTHING

class CurrentFlatInfoProvider extends ChangeNotifier {
  //ALL EXPENCES THAT WILL create a MonthDetail object to save record

  String _selectedFlat = '';

  String _flatName = '';
  double? _flatRentAmount;
  double? _flatGasBill; //= 0.00;
  double? _flatWaterBill; // = 0.00;
  List<OthersExpence>? _flatOtherExpences; //= [];
  double? _electricityUnitPrice; // = 0.00;
  Renter? _renter;

  set currentFlatName(String name) => _selectedFlat = name;

  ///whenever user taps on a flat this class gets updated.
  void updateFlatInfo({
    required Flat currentFlat,
  }) {
    _flatName = currentFlat.flatName;

    _flatRentAmount = currentFlat.flatRentAmount; //*updates
    _flatGasBill = currentFlat.flatGasBill;
    _flatWaterBill = currentFlat.flatWaterBill;
    _flatOtherExpences = currentFlat.flatOtherExpences ??= [];
    // _electricityUnitPrice = currentFlat.electricityUnitPrice ??= 0.00;
    _renter = currentFlat.renter;
    notifyListeners();
  }

  //GETTERS
  String get flatName => _flatName;
  double get flatRentAmount => _flatRentAmount ??= 0;
  String get selectedFlat => _selectedFlat;

  double get flatGasBill => _flatGasBill ??= 0.00;
  double get flatWaterBill => _flatWaterBill ??= 0.00;
  List<OthersExpence> get flatOtherExpences => _flatOtherExpences ??= [];
  double get electricityUnitPrice => _electricityUnitPrice ??= 0.00;
  Renter? get renter => _renter;
}
