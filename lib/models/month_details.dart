import 'package:rent_home/models/transaction_model.dart';
import 'package:rent_home/providers/home_provider.dart';
import 'others_model.dart';

class MonthDetails {
  final String monthNmae; //? it is needed ?
  bool isNotified;
  int? myFlatRent;

  double? electricityUnitPrice;
  double readingOfElecctricMeter;

  double? gasbill;
  double? myWaterBill;
  List<OthersExpence>? myOthersExpences;

  List<Transaction>? transactions = [];

  MonthDetails({
    required this.monthNmae,
    required this.readingOfElecctricMeter,
    this.electricityUnitPrice,
    this.myFlatRent,
    this.myOthersExpences,
    this.gasbill,
    this.isNotified = false,
    this.transactions,
  }) {
    //for null variable take global value from HomeProvider
    HomeProvider homeProvider = HomeProvider();

    myFlatRent ??= homeProvider.homeRentAmount;
    gasbill ??= homeProvider.homeGasbill;
    myWaterBill ??= homeProvider.homewaterBill;
    electricityUnitPrice = homeProvider.electricityUnitPrice;
    myOthersExpences ??= homeProvider.homeOtherExpences;
    transactions ??= []; // it can't be null
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
