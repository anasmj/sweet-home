import 'package:sweet_home/mvvm/models/renter.dart';
import 'package:sweet_home/mvvm/models/service_charges.dart';

class Flat {
  //detail info of flat
  String flatName;
  double
      flatRentAmount; // if not given, taken global value from HomeProvider class
  // int noOfBed, bath, varanda;
  // bool hasDrawingRoom, hasDiningRoom;
  // bool drawingRoom, diningRoom;

  Renter? renter;

  //These values can vary flat to flat. if not given, take global value from HomeProvider
  //every month these values will be used in MonthDetails class to determine bills
  //for that month.
  double flatGasBill;
  double flatWaterBill;
  // double? currentMonthMeterReading;
  double? currentMeterReading;
  double? previousMeterReading;

  List<ServiceCharge>? serviceCharges;

  Flat({
    this.flatName = '',
    this.renter,
    this.flatRentAmount = 0.00,
    this.flatGasBill = 0.00,
    this.flatWaterBill = 0.00,
    this.currentMeterReading,
    this.previousMeterReading,
    this.serviceCharges,
    // this.noOfBed = 1,
    // this.bath = 1,
    // this.varanda = 0,
    // this.hasDiningRoom = false,
    // this.hasDrawingRoom = false,
  });
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
        // noOfBed: json['noOfBed'] ?? 1,
        // bath: json['bath'] ?? 1,
        // varanda: json['varanda'] ?? 0,
        // hasDiningRoom: json['hasDiningRoom'] ?? false,
        // hasDrawingRoom: json['hasDrawingRoom'] ?? false,
        // serviceCharges : json['serviceCharges'],
        currentMeterReading: json['currentMeterReading'],
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
        'currentMeterReading': currentMeterReading,
        'previousMeterReading': previousMeterReading,
        'serviceCharges': serviceCharges ?? [],
        // 'noOfBed': noOfBed,
        // 'bath': bath,
        // 'varanda': varanda,
        // 'hasDiningRoom': hasDiningRoom,
        // 'hasDrawingRoom': hasDrawingRoom,
      };
}
