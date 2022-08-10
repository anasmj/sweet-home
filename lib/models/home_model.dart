import 'package:flutter/cupertino.dart';
import 'package:rent_home/models/others_model.dart';
import 'flat_model.dart';

class Home extends ChangeNotifier {
  String homeName;
  double flatRentAmount;
  List<Flat> flats;
  List<OthersExpence>? otherExpences;

  String? ownerName;
  String? address;
  double? gasbill;
  double? waterBill;
  double electricityUnitPrice;

  Home({
    required this.homeName,
    required this.flatRentAmount,
    required this.electricityUnitPrice,
    required this.flats,
    this.ownerName = '',
    this.address,
    this.gasbill,
    this.waterBill,
    this.otherExpences,
  });
}
