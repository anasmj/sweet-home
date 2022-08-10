import 'package:flutter/widgets.dart';
import 'package:rent_home/models/renter.dart';
import 'others_model.dart';

class Flat with ChangeNotifier {
  String flatName;
  int? flatRentAmount;
  double? gasbill;
  double? waterBill;
  double electricityUnitPrice;
  List<OthersExpence>? othersExpences = [
    OthersExpence(purpose: "A", amount: 100),
    OthersExpence(purpose: "B", amount: 300),
  ];
  Renter? renter;
  Flat({
    this.flatName = 'নাম দেওয়া নেই',
    this.gasbill,
    this.flatRentAmount,
    this.waterBill,
    this.electricityUnitPrice = 0.00,
    this.othersExpences,
    this.renter,
  });
}
