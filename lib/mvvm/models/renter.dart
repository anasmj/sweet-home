import 'package:sweet_home/mvvm/models/transaction.dart';

class Renter {
  String renterName;
  String phoneNo;
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
    required this.phoneNo,
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
      renterName: json['renterName'],
      phoneNo: json['phoneNo'],
      alternatePhoneNo: json['alternatePhoneNo'] ?? '',
      occupation: json['occupation'] ?? '',
      entryDate: DateTime.parse(json['entryDate']),
      numOfPerson: json['noOfPerson'] ?? 1,
      previousLocation: json['previousLocation'] ?? '',
      village: json['village'] ?? '',
      policeStation: json['policeStation'] ?? '',
      union: json['union'] ?? '',
      subDistrict: json['subDistrict'] ?? '',
      district: json['district'] ?? '',
      nIdNumber: json['nIdNumber'],
      renterDue: json['renterDue'] ?? 0.00,
      transactions: transactionList,
    );
    // renter.transactions = transactionList;
    return renter;
  }

  Map<String, dynamic> toJson({RenterTransaction? renterTransaction}) {
    return {
      'renterName': renterName,
      'phoneNo': phoneNo,
      'alternatePhoneNo': alternatePhoneNo ?? '',
      'occupation': occupation ?? '',
      'noOfPerson': numOfPerson ?? 1,
      'entryDate': entryDate.toString(),
      'previousLocation': previousLocation ?? '',
      'village': village ?? '',
      'policeStation:': policeStation ?? '',
      'union:': union ?? '',
      'subDistrict ': subDistrict ?? '',
      'district': district ?? '',
      // 'advance': advance ?? 0.0,
      'nIdNumber': nIdNumber,
      'transactions':
          renterTransaction != null ? [renterTransaction.toJson()] : [],
      'renterDue': renterDue,
      // 'transaction': [renterTransaction.toJson()]
    };
  }
}
