//import 'package:rent_home/models/month_details.dart';

// Map<int, Map> database = {
//   0: {
//     'renter_id': 0,
//     'renter_name': 'Ashraful Islam',
//     'floor': 2,
//     'isNotied': true,
//     'isPaid': false,
//     'annual record': {
//       2022: [
//         MonthDetails(monthNmae: 'Jan', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Feb', noOfDays: "28", paidAt: 5),
//         MonthDetails(monthNmae: 'Mar', noOfDays: "31", paidAt: 2),
//         MonthDetails(monthNmae: 'Apr', noOfDays: "30", paidAt: 6),
//         MonthDetails(monthNmae: 'May', noOfDays: "31", paidAt: 15),
//         MonthDetails(monthNmae: 'Jun', noOfDays: "30", paidAt: 31),
//         MonthDetails(monthNmae: 'Jul', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Aug', noOfDays: "30", paidAt: 15),
//         MonthDetails(monthNmae: 'Sep', noOfDays: "31", paidAt: 3),
//         MonthDetails(monthNmae: 'Oct', noOfDays: "30", paidAt: 30),
//         MonthDetails(monthNmae: 'Nov', noOfDays: "31", paidAt: 12),
//         MonthDetails(monthNmae: 'Dec', noOfDays: "30", paidAt: 16),
//       ],
//       2021: [
//         MonthDetails(monthNmae: 'Jan', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Feb', noOfDays: "28", paidAt: 5),
//         MonthDetails(monthNmae: 'Mar', noOfDays: "31", paidAt: 2),
//         MonthDetails(monthNmae: 'Apr', noOfDays: "30", paidAt: 6),
//         MonthDetails(monthNmae: 'May', noOfDays: "31", paidAt: 15),
//         MonthDetails(monthNmae: 'Jun', noOfDays: "30", paidAt: 31),
//         MonthDetails(monthNmae: 'Jul', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Aug', noOfDays: "30", paidAt: 15),
//         MonthDetails(monthNmae: 'Sep', noOfDays: "31", paidAt: 3),
//         MonthDetails(monthNmae: 'Oct', noOfDays: "30", paidAt: 30),
//         MonthDetails(monthNmae: 'Nov', noOfDays: "31", paidAt: 12),
//         MonthDetails(monthNmae: 'Dec', noOfDays: "30", paidAt: 16),
//       ],
//       2020: [
//         MonthDetails(monthNmae: 'Jan', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Feb', noOfDays: "28", paidAt: 5),
//         MonthDetails(monthNmae: 'Mar', noOfDays: "31", paidAt: 2),
//         MonthDetails(monthNmae: 'Apr', noOfDays: "30", paidAt: 6),
//         MonthDetails(monthNmae: 'May', noOfDays: "31", paidAt: 15),
//         MonthDetails(monthNmae: 'Jun', noOfDays: "30", paidAt: 31),
//         MonthDetails(monthNmae: 'Jul', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Aug', noOfDays: "30", paidAt: 15),
//         MonthDetails(monthNmae: 'Sep', noOfDays: "31", paidAt: 3),
//         MonthDetails(monthNmae: 'Oct', noOfDays: "30", paidAt: 30),
//         MonthDetails(monthNmae: 'Nov', noOfDays: "31", paidAt: 12),
//         MonthDetails(monthNmae: 'Dec', noOfDays: "30", paidAt: 16),
//       ],
//     }
//   },
//   1: {
//     'renter_id': 0,
//     'renter_name': 'Ashraful Islam',
//     'floor': 2,
//     'isNotied': true,
//     'isPaid': false,
//     'annual record': {
//       2022: [
//         MonthDetails(monthNmae: 'Jan', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Feb', noOfDays: "28", paidAt: 5),
//         MonthDetails(monthNmae: 'Mar', noOfDays: "31", paidAt: 2),
//         MonthDetails(monthNmae: 'Apr', noOfDays: "30", paidAt: 6),
//         MonthDetails(monthNmae: 'May', noOfDays: "31", paidAt: 15),
//         MonthDetails(monthNmae: 'Jun', noOfDays: "30", paidAt: 31),
//         MonthDetails(monthNmae: 'Jul', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Aug', noOfDays: "30", paidAt: 15),
//         MonthDetails(monthNmae: 'Sep', noOfDays: "31", paidAt: 3),
//         MonthDetails(monthNmae: 'Oct', noOfDays: "30", paidAt: 30),
//         MonthDetails(monthNmae: 'Nov', noOfDays: "31", paidAt: 12),
//         MonthDetails(monthNmae: 'Dec', noOfDays: "30", paidAt: 16),
//       ],
//       2021: [
//         MonthDetails(monthNmae: 'Jan', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Feb', noOfDays: "28", paidAt: 5),
//         MonthDetails(monthNmae: 'Mar', noOfDays: "31", paidAt: 2),
//         MonthDetails(monthNmae: 'Apr', noOfDays: "30", paidAt: 6),
//         MonthDetails(monthNmae: 'May', noOfDays: "31", paidAt: 15),
//         MonthDetails(monthNmae: 'Jun', noOfDays: "30", paidAt: 31),
//         MonthDetails(monthNmae: 'Jul', noOfDays: "31", paidAt: 8),
//         MonthDetails(monthNmae: 'Aug', noOfDays: "30", paidAt: 15),
//         MonthDetails(monthNmae: 'Sep', noOfDays: "31", paidAt: 3),
//         MonthDetails(monthNmae: 'Oct', noOfDays: "30", paidAt: 30),
//         MonthDetails(monthNmae: 'Nov', noOfDays: "31", paidAt: 12),
//         MonthDetails(monthNmae: 'Dec', noOfDays: "30", paidAt: 16),
//       ],
//     }
//   }
// };
