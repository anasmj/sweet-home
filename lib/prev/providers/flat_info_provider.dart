import 'package:flutter/cupertino.dart';
import '../../mvvm/models/flat_model.dart';

class SelectedFlatProvider extends ChangeNotifier {
  //ALL EXPENCES THAT WILL create a MonthDetail object to save record

  Flat? _selectedFlat;
  set newSelectedFlat(Flat newFame) => _selectedFlat = newFame;
  Flat? get selectedFlat => _selectedFlat;
}
