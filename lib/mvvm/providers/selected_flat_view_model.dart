import 'package:flutter/cupertino.dart';
import '../models/flat_model.dart';

class SelectedFlatVuewModel extends ChangeNotifier {
  //ALL EXPENCES THAT WILL create a MonthDetail object to save record
  late int _noOfBed, _bath, _varanda;
  late bool _hasDining, _hasDrawing;

  Flat? _selectedFlat;
  Flat? get selectedFlat => _selectedFlat;
  set newSelectedFlat(Flat newFlat) {
    _selectedFlat = newFlat;
    //MODIFYING PURPOSE     s
    _noOfBed = newFlat.noOfBed;
    _bath = newFlat.bath;
    _varanda = newFlat.varanda;
    _hasDining = newFlat.hasDiningRoom;
    _hasDrawing = newFlat.hasDrawingRoom;
  }

  int get noOfBed => _noOfBed;
  int get bath => _bath;
  int get varanda => _varanda;

  bool get hasDining => _hasDining;
  bool get hasDrawing => _hasDrawing;

  void changeNoOfBed({required bool shouldIncrease}) {
    shouldIncrease
        ? _noOfBed += 1
        : _noOfBed <= 1
            ? _noOfBed = _noOfBed
            : _noOfBed -= 1;
    notifyListeners();
  }

  void changeBath({required bool shouldIncrease}) {
    shouldIncrease
        ? _bath += 1
        : _bath < 1
            ? _bath = _bath
            : _bath -= 1;

    notifyListeners();
  }

  void changeVaranda({required bool shouldIncrease}) {
    shouldIncrease
        ? _varanda += 1
        : _varanda < 1
            ? _varanda = _varanda
            : _varanda -= 1;
    notifyListeners();
  }

  void changeDining(bool value) {
    _hasDining = value;
    notifyListeners();
  }

  void changeDrawing(bool value) {
    _hasDrawing = value;
    notifyListeners();
  }
}
