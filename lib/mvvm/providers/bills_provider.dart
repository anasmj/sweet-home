import 'package:flutter/cupertino.dart';

import '../models/flat_model.dart';
import 'selected_flat_view_model.dart';

class BillsProvider extends ChangeNotifier {
  SelectedFlatVuewModel? flatProvider;

  double? _previousReading;
  double? _currentReading;

  BillsProvider({required this.flatProvider}) {
    _previousReading = flatProvider!.selectedFlat?.previousMeterReading ?? 0;
    _currentReading = flatProvider!.selectedFlat?.currentMeterReading;
  }
  final double CONST_FACTOR = 0.6;

  double _usedUnit = 0;
  double? get previousReading => _previousReading;
  double? get currentReading => _currentReading;
  double get usedUnit => _usedUnit;
  Flat? get flat => flatProvider!.selectedFlat;

  set setCurrentReading(double reading) {
    _currentReading = reading;
    notifyListeners();
  }

  double? get totalBill =>
      flat!.flatRentAmount +
      flat!.flatGasBill +
      flat!.flatWaterBill +
      electricBill;

  double get electricBill {
    if (previousReading != null && currentReading != null) {
      _usedUnit = currentReading! - previousReading!;
      return (currentReading! - previousReading!) * 0.7;
    }
    return 0;
  }
}
