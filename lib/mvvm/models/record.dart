import 'package:sweet_home/mvvm/models/utility.dart';

//!SUPPORTING FIREBASE
class Record {
  double gasBill, monthlyDue, waterBill, rent;

  double? previousMeterReading,
      presentMeterReading,
      flatRent,
      electricBill,
      unitPrice,
      total,
      grandTotal;

  // Renter? renter;
  String renterName, renterId, renterPhone, renterPhone2;

  List<Utility>? utilities;

  Record({
    this.rent = 0.0,
    this.renterId = '',
    this.renterName = '',
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
    this.electricBill,
  });

  static Record fromJson(Map<String, dynamic> json) {
    Record record;
    List<Utility> utilies = [];
    final utilityMapList = json['utilities'];
    utilityMapList.forEach((item) {
      Utility utility = Utility.fromJson(item as Map<String, dynamic>);
      utilies.add(utility);
    });

    // Utility.fromJson(json['utilities']);
    record = Record(
      renterId: json['renterId'],
      rent: json['rent'],
      renterName: json['renterName'] ?? '',
      renterPhone: json['renterPhone'],
      renterPhone2: json['renterPhone2'],
      // renter:
      //     Renter.fromJson(json['renter']),
      flatRent: json['flatRent'],
      gasBill: json['gasBill'],
      waterBill: json['waterBill'],
      presentMeterReading: json['presentMeterReading'],
      previousMeterReading: json['previousMeterReading'],
      electricBill: json['electricBill'],
      unitPrice: json['unitPrice'],
      total: json['total'],
      grandTotal: json['grandTotal'],
      //utilities
      monthlyDue: json['monthlyDue'],
      // utilities: utilies,
    );

    // print(record);
    return record;
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
      'electricBill': electricBill,
      'renterName': renterName,
      'renterId': renterId,

      'renterPhone': renterPhone,
      'renterPhone2': renterPhone2,
      'rent': rent,
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
