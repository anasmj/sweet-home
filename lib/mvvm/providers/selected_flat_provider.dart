import 'package:flutter/cupertino.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import '../models/flat_model.dart';

class SelectedFlatProvider extends ChangeNotifier {
  SelectedFlatProvider();
  Flat? _selectedFlat;
  Status status = Status.empty;

  Flat? get selectedFlat => _selectedFlat;
  set setSelectedFlat(Flat newFlat) {
    _selectedFlat = newFlat;
    notifyListeners();
  }
}
