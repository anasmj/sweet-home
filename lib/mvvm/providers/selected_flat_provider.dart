import 'package:flutter/cupertino.dart';
import '../models/flat_model.dart';

class SelectedFlatProvider extends ChangeNotifier {
  Flat? _selectedFlat;
  Flat? get selectedFlat => _selectedFlat;
  set newSelectedFlat(Flat newFlat) {
    _selectedFlat = newFlat;
  }
}
