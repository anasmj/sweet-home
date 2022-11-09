import 'package:sweet_home/mvvm/models/utility.dart';

import 'renter.dart';

//!SUPPORTING FIREBASE
class Record {
  double gasBill, monthlyDue, waterBill;
  double? previousMeterReading,
      presentMeterReading,
      flatRent,
      unitPrice,
      total,
      grandTotal;

  // Renter? renter;
  String renterName, renterPhone, renterPhone2;

  List<Utility>? utilities;

  Record(
      {this.renterName = '',
      this.renterPhone = '',
      this.renterPhone2 = '',
      this.flatRent = 0.00,
      this.gasBill = 0.00,
      this.waterBill = 0.00,
      this.presentMeterReading,
      this.previousMeterReading,
      this.unitPrice,
      this.utilities,
      this.monthlyDue = 0.00,
      this.total,
      this.grandTotal,
      thi});

  static fromJson(Map<String, dynamic> json) {
    return Record(
      renterName: json['renterName'] ?? '',
      renterPhone: json['renterPhone'],
      renterPhone2: json['renterPhone2'],
      // renter:
      //     Renter.fromJson(json['renter']), //TODO: saving name should be enough
      flatRent: json['flatRent'],
      gasBill: json['gasBill'],
      waterBill: json['waterBill'],
      presentMeterReading: json['presentMeterReading'],
      previousMeterReading: json['previousMeterReading'],
      unitPrice: json['unitPrice'],
      total: json['total'],

      grandTotal: json['grandTotal'],

      //utilities
      monthlyDue: json['monthlyDue'],
      // usedElectricityUnit: json['usedElectricityUnit'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> utilitiesMap = [];
    if (utilities != null) {
      utilitiesMap = utilities!.map((utility) {
        return utility.toJson();
      }).toList();
      // print(utilitiesMap);
    }
    return {
      // 'renter': renter != null ? renter!.toJson() : null,
      'renterName': renterName,
      'renterPhone': renterPhone,
      'renterPhone2': renterPhone2,
      'flatRent': flatRent,
      'gasBill': gasBill,
      'waterBill': waterBill,
      'previousMeterReading': previousMeterReading,
      'presentMeterReading': presentMeterReading,
      'monthlyDue': monthlyDue,
      'unitPrice': unitPrice,
      'total': total,
      'grandTotal': grandTotal,
      'utilities': utilitiesMap,
    };
  }
}
// import 'renter.dart';

// //!SUPPORTING FIREBASE
// class Record {
//   DateTime issueDate;
//   double? rentAmount;
//   double? gasBill;
//   double? waterBill;
//   double? meterReading;
//   double? renterPayable;
//   Renter? renter;

//   Record({
//     required this.issueDate,
//     required this.rentAmount,
//     required this.renterPayable,
//     this.gasBill,
//     this.waterBill,
//     this.meterReading,
//     // required this.usedElectricityUnit,
//     this.renter,
//   });

//   static fromJson(Map<String, dynamic> json) {
//     Renter renter;
//     Map<String, dynamic> renterJson = json['renter'];
//     renter = Renter.fromJson(renterJson);
//     return Record(
//       issueDate: DateTime.parse(json['issueDate']),
//       rentAmount: json['rentAmount'],
//       renterPayable: json['renterPayable'],
//       // usedElectricityUnit: json['usedElectricityUnit'],
//       meterReading: json['meterReading'],
//       waterBill: json['waterBill'],
//       gasBill: json['gasBill'],
//       renter: renter,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'issueDate': issueDate.toIso8601String(),
//       'rentAmount': rentAmount,
//       'gasBill': gasBill,
//       'waterBill': waterBill,
//       'renterPayable': renterPayable,
//       // 'usedElectricityUnit': usedElectricityUnit,
//       'meterReading': meterReading,
//       'renter': renter != null ? renter!.toJson() : null,
//     };
//   }
// }
