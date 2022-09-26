import 'package:sweet_home/models/year.dart';

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

  double? advance;
  double? unitConsumed;
  List<Year>? records;
  Renter({
    required this.renterName,
    required this.phoneNo,
    this.alternatePhoneNo = '',
    this.occupation = '',
    this.entryDate,
    this.records,
    this.numOfPerson,
    this.previousLocation,
    this.village,
    this.policeStation,
    this.union,
    this.subDistrict,
    this.district,
    this.advance,
    this.unitConsumed,
    this.nIdNumber,
  });

  static Renter fromJson(Map<String, dynamic> json) {
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
      advance: json['advance'] ?? 0.0,
      nIdNumber: json['nIdNumber'],
      // unitConsumed: json['unitConsumed'] ?? 0.0,
    );

    return renter;
  }

  Map<String, dynamic> toJson() => {
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
        'advance': advance ?? 0.0,
        'unitConsumed': unitConsumed ?? 0.0,
        'nIdNumber': nIdNumber,
      };
}

//! do not delete without thinking
//class for pie chart
// class Renter {
//   String name, flatNo, id;
//   int floor;
//   bool isPaid, isNotified;
//   List<MonthDetails>? records;
//   Renter(
//       {this.id = '',
//       required this.name,
//       required this.floor,
//       this.flatNo = '',
//       required this.isPaid,
//       this.isNotified = false,
//       this.records});
// }

// List<Renter> renters = [
//   Renter(
//     id: '0',
//     name: 'Ashraful Islam',
//     floor: 2,
//     isNotified: true,
//     isPaid: false,
//   ),
//   Renter(id: '1', name: 'Rafia Sultana', floor: 1, isPaid: true),
//   Renter(
//     id: '4',
//     name: 'Rifat Merhaj',
//     floor: 2,
//     flatNo: 'A',
//     isPaid: false,
//     isNotified: false,
//   ),
//   Renter(id: '3', name: 'Rabiul Alam', floor: 2, flatNo: 'B', isPaid: true),
//   Renter(
//     id: '5',
//     name: 'Monirul  Hoque',
//     floor: 3,
//     flatNo: 'C',
//     isPaid: false,
//     isNotified: false,
//   ),
//   Renter(
//     id: '6',
//     name: 'Jinia Alam',
//     floor: 3,
//     flatNo: 'A',
//     isPaid: true,
//   ),
// ];
