import 'package:sweet_home/mvvm/models/renter.dart';
import 'package:sweet_home/mvvm/utils/fields.dart';

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
      flatName: json[FlatField.name] ?? '',
      renter: json[FlatField.renter] != null
          ? Renter.fromJson(json[FlatField.renter])
          : null,
      flatRentAmount: json[FlatField.rent] ?? 0.00,
      flatGasBill: json[FlatField.gas] ?? 0.00,
      flatWaterBill: json[FlatField.water] ?? 0.00,
      confirmDate: json[FlatField.confirmDate] != null
          ? DateTime.parse(json[FlatField.confirmDate])
          : null,
      presentMeterReading: json[FlatField.presentReading],
      presentMeterReadingUpdateTime: json[FlatField.presentTime] != null
          ? DateTime.parse(json[FlatField.presentTime])
          : null,
      previousMeterReading: json[FlatField.previousReading] != null
          ? double.parse(json[FlatField.previousReading].toString())
          : null,
      previousMeterReadingUpdateTime: json[FlatField.previousTime] != null
          ? DateTime.parse(json[FlatField.previousTime])
          : null,
      monthlyDue: json[FlatField.due],
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
        FlatField.name: flatName,
        FlatField.rent: rentAmount,
        FlatField.gas: gasBill,
        FlatField.water: waterBill,
        FlatField.presentReading: presentMeterReading,
        FlatField.previousReading: previousMeterReading,
        FlatField.previousTime: previousMeterReadingUpdateTime,
        FlatField.presentTime: presentMeterReadingUpdateTime,
        FlatField.due: monthlyDue,
        FlatField.confirmDate: confirmDate,
        // 'serviceCharges': serviceCharges ?? [],
      };
}
