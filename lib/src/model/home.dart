// import 'package:rent_home/models/others_model.dart';
// import 'flat_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweet_home/src/model/utility.dart';
part 'home.ext.dart';

class Home {
  String? homeId;
  String? homeName;
  int? floor;
  int? flatPerFloor;
  double? rentAmount;
  String? location;
  int? gasBill;
  int? waterBill;
  List<Utility>? utilities;
  Home({
    this.homeId = '',
    this.homeName,
    this.rentAmount,
    this.location,
    this.floor,
    this.flatPerFloor,
    this.gasBill,
    this.waterBill,
    this.utilities,
  });
}
