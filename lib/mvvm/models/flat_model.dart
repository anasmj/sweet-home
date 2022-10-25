import 'package:sweet_home/mvvm/models/renter.dart';

class Flat {
  //detail info of flat
  String flatName;
  double
      flatRentAmount; // if not given, taken global value from HomeProvider class

  Renter? renter;

  //These values can vary flat to flat. if not given, take global value from HomeProvider
  //every month these values will be used in MonthDetails class to determine bills
  //for that month.
  double flatGasBill;
  double flatWaterBill;

  double? currentMeterReading;
  double? previousMeterReading;

  // List<ServiceCharge>? serviceCharges;

  Flat({
    this.flatName = '',
    this.renter,
    this.flatRentAmount = 0.00,
    this.flatGasBill = 0.00,
    this.flatWaterBill = 0.00,
    this.currentMeterReading,
    this.previousMeterReading,
    // this.serviceCharges,
  });
  static Flat fromJson(Map<String, dynamic> json) {
    Renter? renterObj;
    //IF flat is booked, fetch renter
    try {
      Map<String, dynamic> renterData = json['renter'] as Map<String, dynamic>;
      renterObj = Renter.fromJson(renterData);
    } catch (e) {
      //
    }
    // print(json['serviceCharges']);
    return Flat(
        flatName: json['flatName'] ?? '',
        renter: renterObj,
        flatRentAmount: json['rentAmount'] ?? 0.00,
        flatGasBill: json['gasBill'] ?? 0.00,
        flatWaterBill: json['waterBill'] ?? 0.00,
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
        // 'serviceCharges': serviceCharges ?? [],
      };
}
