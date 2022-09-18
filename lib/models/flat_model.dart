import 'package:sweet_home/models/others_model.dart';
import 'package:sweet_home/models/renter.dart';
import '../providers/home_provider.dart';

class Flat {
  //detail info of flat
  String flatName;
  double
      flatRentAmount; // if not given, taken global value from HomeProvider class
  int noOfBed, bath, varanda;
  bool drawingRoom, diningRoom;

  Renter? renter;

  //These values can vary flat to flat. if not given, take global value from HomeProvider
  //every month these values will be used in MonthDetails class to determine bills
  //for that month.
  double flatGasBill;
  double flatWaterBill;

  List<OthersExpence>? flatOtherExpences;

  Flat({
    this.flatName = '',
    this.renter,
    this.flatRentAmount = 0.00,
    this.flatGasBill = 0.00,
    this.flatWaterBill = 0.00,
    this.noOfBed = 1,
    this.bath = 1,
    this.varanda = 1,
    this.diningRoom = false,
    this.drawingRoom = false,
  }) {
    // flatRentAmount ??= HomeProvider().globalRentAmount;
    // flatOtherExpences ??= HomeProvider().globalOtherExpences;
    // electricityUnitPrice ??= HomeProvider().electricityUnitPrice;
    // flatGasBill ??= HomeProvider().globalGasbill;
    // flatWaterBill ??= HomeProvider().globalWaterBill;
  }
  static Flat fromJson(Map<String, dynamic> json) {
    Renter? renter;
    try {
      Map<String, dynamic> renterData = json['renter'] as Map<String, dynamic>;
      renter = Renter.fromJson(renterData);
    } catch (e) {}
    return Flat(
      flatName: json['flatName'] ?? '',
      renter: renter,
      flatRentAmount: json['flatRent'] ?? 0.00,
      flatGasBill: json['gasBill'] ?? 0.00,
      flatWaterBill: json['waterBill'] ?? 0.00,
      noOfBed: json['noOfBed'] ?? 1,
      bath: json['bath'] ?? 1,
      varanda: json['varanda'] ?? 0,
      diningRoom: json['isDiningExists'] ?? false,
      drawingRoom: json['isDrawingExists'] ?? false,
    );
  }

  Map<String, dynamic> toJson(
          {required String flatName, required double rentAmount}) =>
      {
        'flatName': flatName,
        'rentAmount': rentAmount,
        'gasBill': flatGasBill,
        'waterBill': flatWaterBill,
        'noOfBed': noOfBed,
        'bath': bath,
        'varanda': varanda,
        'diningRoom': diningRoom,
        'drawingRoom': drawingRoom,
      };
  static void setRenter(Renter renter) {
    renter = renter;
  }
}
