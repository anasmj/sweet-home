import 'renter.dart';

//!SUPPORTING FIREBASE
class MonthlyRecord {
  DateTime issueDate;
  double? rentAmount;
  double? gasBill;
  double? waterBill;
  double? meterReading;
  double? renterPayable;
  Renter? renter;

  MonthlyRecord({
    required this.issueDate,
    required this.rentAmount,
    required this.renterPayable,
    this.gasBill,
    this.waterBill,
    this.meterReading,
    // required this.usedElectricityUnit,
    this.renter,
  });

  static fromJson(Map<String, dynamic> json) {
    Renter renter;
    Map<String, dynamic> renterJson = json['renter'];
    renter = Renter.fromJson(renterJson);
    return MonthlyRecord(
      issueDate: DateTime.parse(json['issueDate']),
      rentAmount: json['rentAmount'],
      renterPayable: json['renterPayable'],
      // usedElectricityUnit: json['usedElectricityUnit'],
      meterReading: json['meterReading'],
      waterBill: json['waterBill'],
      gasBill: json['gasBill'],
      renter: renter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issueDate': issueDate.toIso8601String(),
      'rentAmount': rentAmount,
      'gasBill': gasBill,
      'waterBill': waterBill,
      'renterPayable': renterPayable,
      // 'usedElectricityUnit': usedElectricityUnit,
      'meterReading': meterReading,
      'renter': renter != null ? renter!.toJson() : null,
    };
  }
}
