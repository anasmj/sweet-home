import 'package:rent_home/models/transaction_model.dart';

class MonthDetails {
  final String monthNmae; //? it is needed ?

  bool isNotified;
  double currentUnitofElectricity;
  List<Transaction>? transactions;
  MonthDetails({
    required this.monthNmae,
    required this.currentUnitofElectricity,
    this.isNotified = false,
    this.transactions,
  });
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
