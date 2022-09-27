import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';

import '../models/flat_model.dart';

class BillsProvider extends ChangeNotifier {
  SelectedFlatProvider? flatProvider;

  double? _previousReading;
  double? _currentReading;

  BillsProvider({required this.flatProvider}) {
    _previousReading = flatProvider!.selectedFlat?.previousMeterReading ?? 0;
    _currentReading = flatProvider!.selectedFlat?.currentMeterReading ?? 0;
  }
  final double CONST_FACTOR = 0.6;

  double _usedUnit = 0;
  double? get previousReading => _previousReading;
  double? get currentReading => _currentReading;
  double get usedUnit => _usedUnit;
  Flat? get flat => flatProvider!.selectedFlat;

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
