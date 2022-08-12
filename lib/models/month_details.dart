import 'package:rent_home/models/transaction_model.dart';

import 'home_model.dart';
import 'others_model.dart';

class MonthDetails extends Home {
  final String monthNmae; //? it is needed ?

  //! almost every parameter present is home is needed to copy here
  //! for the sake of keeping monthly history of a renter
  bool isNotified;
  double currentUnitofElectricity;
  int? myFlatRent;
  double? electricUnitUsed;

  double? gasbill; //can be set flatwise
  double? myWaterBill; //managed globally from home class
  double? myElectricityUnitPrice; //managed globally from home class
  double? usedUnitOfElectricity; //it will go in month parameter
  List<OthersExpence>? myOthersExpences;

  List<Transaction>? transactions;
  MonthDetails({
    required this.monthNmae,
    required this.currentUnitofElectricity,
    this.myFlatRent,
    this.myOthersExpences,
    this.gasbill,
    this.isNotified = false,
    this.transactions,
  }) {
    //for null variable take global value from Home class
    myFlatRent ??= super.globalRentAmount;
    gasbill ??= super.globalGasBill;
    myWaterBill ??= super.waterBill;
    myElectricityUnitPrice ??= super.electricityUnitPrice;
    myOthersExpences ??= super.globalOtherExpences;
  }
}

// List<MonthDetails> listOfMonthDetails = [
//   MonthDetails(monthNmae: 'Jan', noOfDays: 31, paidAt: 8),
//   MonthDetails(monthNmae: 'Feb', noOfDays: 28, paidAt: 5),
//   MonthDetails(monthNmae: 'Mar', noOfDays: 31, paidAt: 2),
//   MonthDetails(monthNmae: 'Apr', noOfDays: 30, paidAt: 6),
//   MonthDetails(monthNmae: 'May', noOfDays: 31, paidAt: 15),
//   MonthDetails(monthNmae: 'Jun', noOfDays: 30, paidAt: 31),
//   MonthDetails(monthNmae: 'Jul', noOfDays: 31, paidAt: 8),
//   MonthDetails(monthNmae: 'Aug', noOfDays: 30, paidAt: 15),
//   MonthDetails(monthNmae: 'Sep', noOfDays: 31, paidAt: 3),
//   MonthDetails(monthNmae: 'Oct', noOfDays: 30, paidAt: 30),
//   MonthDetails(monthNmae: 'Nov', noOfDays: 31, paidAt: 12),
//   MonthDetails(monthNmae: 'Dec', noOfDays: 30, paidAt: 16),
// ];

//!might be used in pie chart
// List<MonthDetails> listOfMonthDetails = [
//   MonthDetails(monthNmae: 'Jan', noOfDays: "31", paidAt: 8),
//   MonthDetails(monthNmae: 'Feb', noOfDays: "28", paidAt: 5),
//   MonthDetails(monthNmae: 'Mar', noOfDays: "31", paidAt: 2),
//   MonthDetails(monthNmae: 'Apr', noOfDays: "30", paidAt: 6),
//   MonthDetails(monthNmae: 'May', noOfDays: "31", paidAt: 15),
//   MonthDetails(monthNmae: 'Jun', noOfDays: "30", paidAt: 31),
//   MonthDetails(monthNmae: 'Jul', noOfDays: "31", paidAt: 8),
//   MonthDetails(monthNmae: 'Aug', noOfDays: "30", paidAt: 15),
//   MonthDetails(monthNmae: 'Sep', noOfDays: "31", paidAt: 3),
//   MonthDetails(monthNmae: 'Oct', noOfDays: "30", paidAt: 30),
//   MonthDetails(monthNmae: 'Nov', noOfDays: "31", paidAt: 12),
//   MonthDetails(monthNmae: 'Dec', noOfDays: "30", paidAt: 16),
// ];
