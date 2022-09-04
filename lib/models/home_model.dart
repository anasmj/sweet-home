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
        'Gas Bill': gasBill ?? 0,
        'Water Bill': waterBill ?? 0,
      };
  static fromJson(Map<String, dynamic> data) => Home(
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




//!HomeProvider is being used instead 

// class Home {
//   String homeName;
//   String? ownerName;
//   String? address;

//   //THESE VARIABLE MAY DIFFER BY FLATS
//   //which are to be controlled from FLAT class
//   int globalRentAmount;
//   List<OthersExpence>? globalOtherExpences;
//   double globalGasBill;

//   //FOR EVERY FALT THESE VARIABLE REMAINSF SAME
//   double waterBill;
//   double electricityUnitPrice;

//   List<Flat>? flats;

//   Home({
//     this.homeName = '',
//     this.globalRentAmount = 0,
//     this.electricityUnitPrice = 0.00,
//     this.flats,
//     this.ownerName,
//     this.address,
//     this.globalGasBill = 0.00,
//     this.waterBill = 0.00,
//     this.globalOtherExpences,
//   }) {
//     // print('home model created with rent $globalRentAmount');
//   }

//   set setHomeName(String name) {
//     homeName = homeName;
//   }

//   set rentAmount(int amount) {
//     globalRentAmount = amount;
//   }

//   set assignFlats(List<Flat> flats) {
//     this.flats = flats;
//   }

//   set setOwnerName(String name) {
//     ownerName = name;
//   }

//   set setAddress(String add) {
//     address = add;
//   }

//   set setGasBill(double bill) {
//     globalGasBill = bill;
//   }

//   set setWaterBill(double bill) {
//     waterBill = bill;
//   }

//   set setOtherExpences(List<OthersExpence> expences) {
//     globalOtherExpences = expences;
//   }
// }
