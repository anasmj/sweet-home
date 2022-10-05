import 'package:sweet_home/prev/models/monthly_record.dart';
import 'package:sweet_home/prev/models/others_model.dart';
import 'package:sweet_home/prev/models/renter.dart';

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
  // double? currentMonthMeterReading;
  double? currentMeterReading;
  double? previousMeterReading;

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
    this.currentMeterReading,
    this.previousMeterReading,
  }) {
    // flatRentAmount ??= HomeProvider().globalRentAmount;
    // flatOtherExpences ??= HomeProvider().globalOtherExpences;
    // electricityUnitPrice ??= HomeProvider().electricityUnitPrice;
    // flatGasBill ??= HomeProvider().globalGasbill;
    // flatWaterBill ??= HomeProvider().globalWaterBill;
  }
  static Flat fromJson(Map<String, dynamic> json) {
    Renter? renterObj;
    //IF flat is booked, fetch renter
    try {
      Map<String, dynamic> renterData = json['renter'] as Map<String, dynamic>;
      renterObj = Renter.fromJson(renterData);
    } catch (e) {}
    return Flat(
        flatName: json['flatName'] ?? '',
        renter: renterObj,
        flatRentAmount: json['rentAmount'] ?? 0.00,
        flatGasBill: json['gasBill'] ?? 0.00,
        flatWaterBill: json['waterBill'] ?? 0.00,
        noOfBed: json['noOfBed'] ?? 1,
        bath: json['bath'] ?? 1,
        varanda: json['varanda'] ?? 0,
        diningRoom: json['isDiningExists'] ?? false,
        drawingRoom: json['isDrawingExists'] ?? false,
        currentMeterReading: json['currentMeterReading'],
        // currentMonthMeterReading: json['currentMonthMeterReading'] ?? 0.0,
        previousMeterReading: json['previousMeterReading'] != null
            ? double.parse(json['previousMeterReading'].toString())
            : null);
  }

  Map<String, dynamic> toJson({
    required String flatName,
    required double rentAmount,
    double gasBill = 0.00,
    double waterBill = 0.00,
    double? previousMeterReading,
  }) =>
      {
        'flatName': flatName,
        'rentAmount': rentAmount,
        'gasBill': gasBill,
        'waterBill': waterBill,
        'noOfBed': noOfBed,
        'bath': bath,
        'varanda': varanda,
        'isDiningExists': diningRoom,
        'isDrawingExists': drawingRoom,
        'currentMeterReading': currentMeterReading,
        'previousMeterReading': previousMeterReading,
      };
  // static void setRenter(Renter renter) {
  //   renter = renter;
  // }
}
