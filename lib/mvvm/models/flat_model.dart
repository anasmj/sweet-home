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
  double monthlyDue;
  double? presentMeterReading;
  double? previousMeterReading;
  DateTime? previousMeterReadingUpdateTime,
      presentMeterReadingUpdateTime,
      confirmDate;

  // List<ServiceCharge>? serviceCharges;

  Flat({
    this.flatName = '',
    this.renter,
    this.flatRentAmount = 0.00,
    this.flatGasBill = 0.00,
    this.flatWaterBill = 0.00,
    this.presentMeterReading,
    this.previousMeterReading,
    this.previousMeterReadingUpdateTime,
    this.presentMeterReadingUpdateTime,
    this.monthlyDue = 0.00,
    this.confirmDate,
    // this.serviceCharges,
  });
  static Flat fromJson(Map<String, dynamic> json) {
    return Flat(
      flatName: json['flatName'] ?? '',
      renter: json['renter'] != null ? Renter.fromJson(json['renter']) : null,
      flatRentAmount: json['rentAmount'] ?? 0.00,
      flatGasBill: json['gasBill'] ?? 0.00,
      flatWaterBill: json['waterBill'] ?? 0.00,
      monthlyDue: json['monthlyDue'],
      confirmDate: DateTime.tryParse(json['confirmDate'].toString()),
      presentMeterReading: json['presentMeterReading'],
      presentMeterReadingUpdateTime:
          json['presentMeterReadingUpdateTime'] != null
              ? DateTime.parse(json['presentMeterReadingUpdateTime'])
              : null,
      previousMeterReading: json['previousMeterReading'] != null
          ? double.parse(json['previousMeterReading'].toString())
          : null,
      previousMeterReadingUpdateTime:
          json['previousMeterReadingUpdateTime'] != null
              ? DateTime.parse(json['previousMeterReadingUpdateTime'])
              : null,
    );
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
        'presentMeterReading': presentMeterReading,
        'previousMeterReading': previousMeterReading,
        'previousMeterReadingUpdateTime': previousMeterReadingUpdateTime,
        'presentMeterReadingUpdateTime': presentMeterReadingUpdateTime,
        'monthlyDue': monthlyDue,
        'confirmDate': confirmDate,
        // 'serviceCharges': serviceCharges ?? [],
      };
}
