// import 'package:rent_home/models/others_model.dart';
// import 'flat_model.dart';

import 'package:sweet_home/mvvm/models/service_charges.dart';

class Home {
  String homeId;
  final String homeName;
  final int floor;
  final int flatPerFloor;
  final double rentAmount;
  final String location;
  final double? gasBill;
  final double? waterBill;
  final List<Utility>? utilities;
  Home({
    this.homeId = '',
    required this.homeName,
    required this.rentAmount,
    required this.location,
    required this.floor,
    required this.flatPerFloor,
    this.gasBill,
    this.waterBill,
    this.utilities,
  });

  //returns a map
  Map<String, dynamic> toJson() => {
        'homeId': homeId,
        'homeName': homeName,
        'location': location,
        'floor': floor,
        'flatPerFloor': flatPerFloor,
        'rentAmount': rentAmount,
        'gasBill': gasBill ?? 0.00,
        'waterBill': waterBill ?? 0.00,
        'utilities': utilities,
      };
  static Home fromJson(Map<String, dynamic> data) => Home(
        homeName: data['homeName'] ?? '',
        homeId: data['homeId'] ?? '',
        rentAmount: data['rentAmount'] ?? 0.00,
        location: data['location'] ?? '',
        flatPerFloor: data['flatPerFloor'] ?? 0,
        floor: data['floor'] ?? 0,
        gasBill: data['gasBill'] ?? 0.00,
        waterBill: data['waterBill'] ?? 0.00,
        // serviceCharges:
      );
}
