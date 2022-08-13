import 'package:flutter/cupertino.dart';
import 'package:rent_home/models/renter.dart';
import '../providers/home_provider.dart';

class Flat {
  String flatName;
  int? flatRentAmount;

  //detail info of flat
  int? noOfBed, bath, varanda;
  bool? drawingRoom, diningRoom;

  Renter? renter;

  Flat({
    required this.flatName,
    this.renter,
    this.flatRentAmount,
  }) {
    flatRentAmount ??= HomeProvider().homeRentAmount;
  }
}
