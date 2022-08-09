import 'package:flutter/cupertino.dart';

class FlatInfoProvider extends ChangeNotifier {
  String? flatName;
  int? rentAmount;
  double? gasbill;
  double? waterBill = 0;
  double? electricityUnitPrice = 7.50;
}
