import 'package:flutter/cupertino.dart';
import 'package:rent_home/models/database.dart';
import '../models/flat_model.dart';
import '../models/others_model.dart';

//VALUE IN THIS CLASSS ARE PROVIDED INTO FLATS GLOBALLY
class HomeProvider extends ChangeNotifier {
  final String _homeName = '';
  final String _ownerName = '';
  final String _address = '';

  final int _globalRentAmount = 8500;
  // List<OthersExpence>? _otherExpenceList; //!this is not allowed
  final double _globalGasBill = 600;

  final double _homeWaterBill = 0;
  final double _electricityUnitPrice = 7.50;
  final double _electricityBill = 0; //TODO: needs to get updated

  List<Flat>? _flats;

  String get homeName => _homeName;
  String get ownerName => ownerName;
  String get address => _address;

  double get electricityUnitPrice => _electricityUnitPrice;
  int get globalRentAmount => _globalRentAmount;
  List<OthersExpence>? get globalOtherExpences =>
      globalOtherExpenceList; //this list is kept in database file
  double? get globalGasbill => _globalGasBill;
  double? get globalWaterBill => _homeWaterBill;
  List<Flat> get flats => databaseFlatList;
}
