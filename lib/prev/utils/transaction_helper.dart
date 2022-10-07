// import 'package:sweet_home/prev/models/month_details.dart';


// import '../../mvvm/models/renter.dart';
// import '../../mvvm/models/renter_transaction.dart';
// import '../models/year.dart';

// class TransactionHelper {
//   Renter renter;
//   DateTime? transactionDate;

//   late MonthDetails currentMonth;

//   TransactionHelper.makeTransaction({
//     required this.renter,
//     required this.transactionDate,
//   });
//   TransactionHelper({required this.renter});

//   //! incomplete function, more parameter needed
//   void addTransaction(Renter renter, date, amount) {
//     Year currentYear = renter
//         .records![renter.records!.length - 1]; //last element of List<year>
//     currentMonth = currentYear.months[currentYear.months.length - 1];

//     List<RenterTransaction> userTransactionList = currentMonth.transactions!;
//     userTransactionList.add(RenterTransaction(
//         takenAmount: 45, timeStamp: DateTime.parse('2022-03-33 20:18:04Z')));
//   }

//   //returns list of transactions made by a user
//   List<RenterTransaction> listOfAllTransactions() {
//     List<RenterTransaction> transactionList = [];
//     renter.records!.forEach(
//       (year) => year.months.forEach(
//         (monthDetail) {
//           monthDetail.transactions!.forEach(
//             (transaction) {
//               transactionList.add(transaction);
//             },
//           );
//         },
//       ),
//     );
//     return transactionList;
//   }
// }
