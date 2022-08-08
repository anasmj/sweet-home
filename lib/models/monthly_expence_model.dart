import 'package:rent_home/models/others_model.dart';

//!might be deleted
class MonthlyExpenceModel {
  double homeRent;
  double? gasBill, waterBill;
  OthersExpence? othersExpences;

  MonthlyExpenceModel({
    required this.homeRent,
    this.gasBill,
    this.waterBill,
    this.othersExpences,
  });
}
