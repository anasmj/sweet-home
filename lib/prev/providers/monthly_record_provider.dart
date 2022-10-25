import 'package:flutter/cupertino.dart';

class MonthlyRecordProvider extends ChangeNotifier {
  double? _meterReading;

  double? get meterReading => _meterReading;
  set setMeterReading(double value) {
    _meterReading = value;
    //update records in flat record
    notifyListeners();
  }
}
