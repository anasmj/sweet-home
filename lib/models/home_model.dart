import 'package:flutter/cupertino.dart';
import 'package:rent_home/models/others_model.dart';
import 'flat_model.dart';

class Home {
  String homeName;
  String? ownerName;
  String? address;

  //THESE VARIABLE MAY DIFFER BY FLATS
  //which are to be controlled from FLAT class
  int globalRentAmount;
  List<OthersExpence>? globalOtherExpences;
  double globalGasBill;

  //FOR EVERY FALT THESE VARIABLE REMAINSF SAME
  double waterBill;
  double electricityUnitPrice;

  List<Flat>? flats;

  Home({
    this.homeName = '',
    this.globalRentAmount = 0,
    this.electricityUnitPrice = 0.00,
    this.flats,
    this.ownerName,
    this.address,
    this.globalGasBill = 0.00,
    this.waterBill = 0.00,
    this.globalOtherExpences,
  }) {
    // print('home model created with rent $globalRentAmount');
  }

  set setHomeName(String name) {
    homeName = homeName;
  }

  set rentAmount(int amount) {
    globalRentAmount = amount;
  }

  set assignFlats(List<Flat> flats) {
    this.flats = flats;
  }

  set setOwnerName(String name) {
    ownerName = name;
  }

  set setAddress(String add) {
    address = add;
  }

  set setGasBill(double bill) {
    globalGasBill = bill;
  }

  set setWaterBill(double bill) {
    waterBill = bill;
  }

  set setOtherExpences(List<OthersExpence> expences) {
    globalOtherExpences = expences;
  }
}
