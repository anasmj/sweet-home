part of 'flat.dart';

extension FlatExtension on Flat {
  Flat fromJson(Map<String, dynamic> json) {
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
