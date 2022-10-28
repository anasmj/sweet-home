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
  double account;
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
    this.account = 0,
    // this.renterTransaction,
  });

  static Renter fromJson(Map<String, dynamic> json) {
    List<RenterTransaction> transactionList = [];
    final transactionMap = json['transactions'];
    transactionMap.forEach((transaction) {
      transactionList
          .add(RenterTransaction.fromJson(transaction as Map<String, dynamic>));
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
      // advance: json['advance'] ?? 0.0,
      nIdNumber: json['nIdNumber'],
      account: json['account'] ?? 0.00,
      transactions: transactionList,
      // unitConsumed: json['unitConsumed'] ?? 0.0,
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
      'account': account,
      // 'transaction': [renterTransaction.toJson()]
    };
  }
}
