import 'package:sweet_home/mvvm/models/transaction.dart';
import 'package:sweet_home/mvvm/utils/fields.dart';

class Renter {
  String renterName;
  String id;
  String phone;
  String? alternatePhoneNo;
  String? occupation;
  int? numOfPerson;
  DateTime? entryDate;
  int? nIdNumber;
  String? previousLocation;
  String? village;
  String? policeStation;
  String? union;
  String? subDistrict;
  String? district;
  double renterDue;
  RenterTransaction? renterTransaction;

  // double? advance;

  List<RenterTransaction>? transactions;

  Renter({
    required this.renterName,
    required this.id,
    required this.phone,
    this.alternatePhoneNo = '',
    this.occupation = '',
    this.entryDate,
    this.numOfPerson,
    this.previousLocation,
    this.village,
    this.policeStation,
    this.union,
    this.subDistrict,
    this.district,
    // this.advance,
    this.nIdNumber,
    this.transactions,
    this.renterDue = 0,
    // this.renterTransaction,
  });

  static Renter fromJson(Map<String, dynamic> json) {
    List<RenterTransaction> transactionList = [];

    final transactionMapList = json['transactions'];
    transactionMapList.forEach((item) {
      RenterTransaction transaction =
          RenterTransaction.fromJson(item as Map<String, dynamic>);
      transactionList.add(transaction);
    });
    Renter renter;

    renter = Renter(
      renterName: json[RenterField.name],
      id: json[RenterField.id],
      phone: json[RenterField.ph],
      alternatePhoneNo: json[RenterField.ph2] ?? '',
      occupation: json[RenterField.occupation_] ?? '',
      entryDate: DateTime.parse(json[RenterField.entryDate_]),
      numOfPerson: json[RenterField.numOfPerson_] ?? 1,
      previousLocation: json[RenterField.previousLocation_] ?? '',
      village: json[RenterField.vill] ?? '',
      policeStation: json[RenterField.policeSt] ?? '',
      union: json[RenterField.union_] ?? '',
      subDistrict: json[RenterField.subDistrict_] ?? '',
      district: json[RenterField.dist_] ?? '',
      nIdNumber: json[RenterField.nId],
      renterDue: json[RenterField.due_] ?? 0.00,
      transactions: transactionList,
    );
    // renter.transactions = transactionList;
    return renter;
  }

  Map<String, dynamic> toJson({RenterTransaction? renterTransaction}) {
    return {
      RenterField.name: renterName,
      RenterField.id: id,
      RenterField.ph: phone,
      RenterField.ph2: alternatePhoneNo ?? '',
      RenterField.occupation_: occupation ?? '',
      RenterField.numOfPerson_: numOfPerson ?? 1,
      RenterField.entryDate_: entryDate.toString(),
      RenterField.previousLocation_: previousLocation ?? '',
      RenterField.vill: village ?? '',
      RenterField.policeSt: policeStation ?? '',
      RenterField.union_: union ?? '',
      RenterField.subDistrict_: subDistrict ?? '',
      RenterField.dist_: district ?? '',
      RenterField.nId: nIdNumber,
      RenterField.transactions_:
          renterTransaction != null ? [renterTransaction.toJson()] : [],
      RenterField.due_: renterDue,
      // 'transaction': [renterTransaction.toJson()]
    };
  }
}
