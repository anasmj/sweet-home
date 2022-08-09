import 'package:rent_home/models/renter.dart';
import 'others_model.dart';

class Flat {
  String flatName;
  int? rentAmount;
  double? gasbill;
  double? waterBill = 0;
  double? electricityUnitPrice = 7.50;
  List<OthersExpence>? othersExpences = [
    OthersExpence(purpose: "A", amount: 100),
    OthersExpence(purpose: "B", amount: 300),
  ];
  Renter? renter;
  Flat({
    required this.flatName,
    this.gasbill,
    this.rentAmount = 7500,
    this.waterBill,
    this.electricityUnitPrice,
    this.othersExpences,
    this.renter,
  });
}
