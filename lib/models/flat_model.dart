import 'package:flutter/widgets.dart';
import 'package:rent_home/models/renter.dart';
import 'others_model.dart';

class Flat with ChangeNotifier {
  String flatName;
  int? rentAmount;
  double? gasbill;
  double? waterBill = 0;
  double? electricityUnitPrice;
  List<OthersExpence>? othersExpences = [
    OthersExpence(purpose: "A", amount: 100),
    OthersExpence(purpose: "B", amount: 300),
  ];
  Renter? renter;
  Flat({
    this.flatName = 'নাম দেওয়া নেই',
    this.gasbill = 800,
    this.rentAmount = 7500,
    this.waterBill,
    this.electricityUnitPrice = 7.50,
    this.othersExpences,
    this.renter,
  });
}
