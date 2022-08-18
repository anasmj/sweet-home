import 'package:flutter/cupertino.dart';

import '../models/flat_model.dart';
import '../models/others_model.dart';

///PROVIDES INFORMATION RAELATED TO RENTER OF FLAT CLICKED BY USER.
///VALUES WILL BE TAKEN TO CREATE NEW MonthDetail
///OBJECT; IF THERE ARE ALREADY VALUE IN MONTH DETAILS THEN
///DO NOTHING

class CurrentFlatInfoProvider extends ChangeNotifier {
  //ALL EXPENCES THAT WILL create a MonthDetail object to save record

  String _flatName = '';
  int _flatRentAmount = 0;
  double _flatGasBill = 0.00;
  double _flatWaterBill = 0.00;
  List<OthersExpence> _flatOtherExpences = [];
  double _electricityUnitPrice = 0.00;

  ///whenever user taps on a flat this class gets updated.
  void updateFlatInfo({
    required Flat currentFlat,
    // String flatName = '',
    // int flatRentAmount = 0,
    // double flatGasBill = 0.00,
    // double flatWaterBill = 0.00,
    // List<OthersExpence>? otherExpenceList,
    // double electricityUnitPrice = 0.00,
  }) {
    _flatName = currentFlat.flatName;
    _flatRentAmount = currentFlat.flatRentAmount ??= 0;
    _flatGasBill = currentFlat.flatGasBill ??= 0.00;
    _flatWaterBill = currentFlat.flatWaterBill ??= 0.00;
    _flatOtherExpences = currentFlat.flatOtherExpences ??= [];
    _electricityUnitPrice = currentFlat.electricityUnitPrice ??= 0.00;
    notifyListeners();
  }

  //GETTERS
  String get flatName => _flatName;
  int get flatRentAmount => _flatRentAmount;
  double get flatGasBill => _flatGasBill;
  double get flatWaterBill => _flatWaterBill;
  List<OthersExpence> get flatOtherExpences => _flatOtherExpences;
  double get electricityUnitPrice => _electricityUnitPrice;

  // //SETTERS
  // set flatName(String name) {
  //   _flatName = name;
  // }

  // set flatRentAmount(int amount) {
  //   _flatRentAmount = amount;
  // }

  // set flatgasBill(double bill) {
  //   _flatGasBill = bill;
  // }

  // set flatWaterBill(double bill) {
  //   _flatWaterBill = bill;
  // }

  // set flatOtherExpences(List<OthersExpence> otherExpence) {
  //   _flatOtherExpences = otherExpence;
  // }

  // set electricityUnitPrice(double price) {
  //   _electricityUnitPrice = price;
  // }
}
