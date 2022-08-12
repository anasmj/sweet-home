import 'package:rent_home/models/renter.dart';

import 'home_model.dart';

class Flat extends Home {
  String flatName;
  int? flatRentAmount;

  //detail info of flat
  int? noOfBed, bath, varanda;
  bool? drawingRoom, diningRoom;

  Renter? renter;

  Flat({
    required this.flatName,
    this.flatRentAmount,
    this.renter,
  }) {
    flatRentAmount ??= globalRentAmount;
    print('flat constructor rent amount $flatRentAmount ');
  }
}
