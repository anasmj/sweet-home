// import 'package:rent_home/models/others_model.dart';
// import 'flat_model.dart';

import 'package:sweet_home/src/model/utility.dart';
part 'home.ext.dart';

class Home {
  String? homeId;
  String? homeName;
  int? floor;
  int? flatPerFloor;
  int? rentAmount;
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
