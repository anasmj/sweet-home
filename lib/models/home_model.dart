// import 'package:rent_home/models/others_model.dart';
// import 'flat_model.dart';

class Home {
  String homeId;
  final String homeName;
  final int floor;
  final int flatPerFloor;
  final double rentAmount;
  final String location;
  final double? gasBill;
  final double? waterBill;
  Home({
    this.homeId = '',
    required this.homeName,
    required this.rentAmount,
    required this.location,
    required this.floor,
    required this.flatPerFloor,
    this.gasBill,
    this.waterBill,
  });

  //returns a map
  Map<String, dynamic> toJson() => {
        'Home Id': homeId,
        'Home Name': homeName,
        'Location': location,
        'Floor': floor,
        'Flat Per Floor': flatPerFloor,
        'Rent Amount': rentAmount,
        'Gas Bill': gasBill ?? 0.00,
        'Water Bill': waterBill ?? 0.00,
      };
  static Home fromJson(Map<String, dynamic> data) => Home(
        homeName: data['Home Name'],
        homeId: data['Home Id'],
        rentAmount: data['Rent Amount'],
        location: data['Location'],
        flatPerFloor: data['Flat Per Floor'],
        floor: data['Floor'],
        gasBill: data['Gas Bill'],
        waterBill: data['Water Bill'],
      );
}
