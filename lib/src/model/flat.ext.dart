part of 'flat.dart';

extension FlatExt on Flat {
  static Flat fromJson(Map<String, dynamic> json) {
    return Flat(
      flatName: json[FlatField.name] ?? '',
      renter: json[FlatField.renter] != null
          ? Renter.fromJson(json[FlatField.renter])
          : null,
      flatRentAmount: json[FlatField.rent] ?? 0,
      flatGasBill: json[FlatField.gas] ?? 0,
      flatWaterBill: json[FlatField.water] ?? 0,
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
    required int rentAmount,
    int gasBill = 0,
    int waterBill = 0,
    double? previousMeterReading,
    RenterTransaction? renterTransaction,
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

        // 'serviceCharges': serviceCharges ?? [],
      };
}
