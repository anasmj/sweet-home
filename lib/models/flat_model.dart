import 'package:sweet_home/models/others_model.dart';
import 'package:sweet_home/models/renter.dart';
import '../providers/home_provider.dart';

class Flat {
  //detail info of flat
  String flatName;
  int?
      flatRentAmount; // if not given, taken global value from HomeProvider class
  int? noOfBed, bath, varanda;
  bool? drawingRoom, diningRoom;

  Renter? renter;

  //These values can vary flat to flat. if not given, take global value from HomeProvider
  //every month these values will be used in MonthDetails class to determine bills
  //for that month.
  double? flatGasBill;
  double? flatWaterBill;
  double? electricityUnitPrice; //always takes global value

  List<OthersExpence>? flatOtherExpences;

  Flat({
    this.flatName = '',
    this.renter,
    this.flatRentAmount,
  }) {
    flatRentAmount ??= HomeProvider().globalRentAmount;
    flatOtherExpences ??= HomeProvider().globalOtherExpences;
    electricityUnitPrice ??= HomeProvider().electricityUnitPrice;
    flatGasBill ??= HomeProvider().globalGasbill;
    flatWaterBill ??= HomeProvider().globalWaterBill;
  }
}
