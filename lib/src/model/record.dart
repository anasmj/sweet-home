import 'package:sweet_home/src/model/utility.dart';

import '../constants/constants.dart';

class UserMonthlyRecord {
  double gasBill, monthlyDue, waterBill;
  double? previousMeterReading,
      presentMeterReading,
      flatRent,
      electricBill,
      electricityUnitPrice,
      total,
      renterDue,
      paid,
      grandTotal;

  String renterName, renterId, renterPhone, renterPhone2, recordId;

  List<Utility>? utilities;

  UserMonthlyRecord({
    this.renterId = '',
    required this.recordId,
    this.renterName = '',
    this.renterPhone = '',
    this.renterPhone2 = '',
    this.renterDue = 0.00,
    this.flatRent = 0.00,
    this.gasBill = 0.00,
    this.waterBill = 0.00,
    this.presentMeterReading,
    this.previousMeterReading,
    this.electricityUnitPrice,
    this.utilities,
    this.monthlyDue = 0.00,
    this.total,
    this.paid = 0,
    this.grandTotal,
    this.electricBill,
  });

  static UserMonthlyRecord fromJson(Map<String, dynamic> json) {
    UserMonthlyRecord record;
    List<Utility> utilies = [];
    final utilityMapList = json[RecordField.utilities];
    utilityMapList.forEach((item) {
      Utility utility = Utility.fromJson(item as Map<String, dynamic>);
      utilies.add(utility);
    });
    record = UserMonthlyRecord(
      renterId: json[RecordField.renterId],
      recordId: json[RecordField.id] ?? '',
      renterDue: json[RecordField.renterDue],
      renterName: json[RecordField.renterName] ?? '',
      renterPhone: json[RecordField.renterPhone],
      renterPhone2: json[RecordField.renterPhone2],
      flatRent: json[RecordField.flatRent],
      gasBill: json[RecordField.gasBill],
      waterBill: json[RecordField.waterBill],
      presentMeterReading: json[RecordField.presentMeterReading],
      previousMeterReading: json[RecordField.previousMeterReading],
      electricBill: json[RecordField.electricBill],
      electricityUnitPrice: json[RecordField.unitPrice],
      total: json[RecordField.total],
      paid: json[RecordField.paid],
      grandTotal: json[RecordField.grandTotal],
      monthlyDue: json[RecordField.monthlyDue],
    );

    return record;
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> utilitiesMap = [];
    if (utilities != null) {
      utilitiesMap = utilities!.map((utility) {
        return utility.toJson();
      }).toList();
    }
    return {
      // 'renter': renter != null ? renter!.toJson() : null,
      RecordField.electricBill: electricBill,
      RecordField.flatRent: flatRent,
      RecordField.id: recordId,
      RecordField.renterName: renterName,
      RecordField.renterId: renterId,
      RecordField.renterDue: renterDue,
      RecordField.paid: paid ?? 0,
      RecordField.renterPhone: renterPhone,
      RecordField.renterPhone2: renterPhone2,
      RecordField.gasBill: gasBill,
      RecordField.waterBill: waterBill,
      RecordField.previousMeterReading: previousMeterReading,
      RecordField.presentMeterReading: presentMeterReading,
      RecordField.monthlyDue: monthlyDue,
      RecordField.unitPrice: electricityUnitPrice,
      RecordField.total: total,
      RecordField.grandTotal: grandTotal,
      RecordField.utilities: utilitiesMap,
    };
  }
}
