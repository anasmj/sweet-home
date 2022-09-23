import 'package:sweet_home/models/month_details.dart';
import 'package:sweet_home/models/renter.dart';

import '../models/transaction_model.dart';
import '../models/year.dart';

class TransactionHelper {
  Renter renter;
  DateTime? transactionDate;

  late MonthDetails currentMonth;

  TransactionHelper.makeTransaction({
    required this.renter,
    required this.transactionDate,
  });
  TransactionHelper({required this.renter});

  //! incomplete function, more parameter needed
  void addTransaction(Renter renter, date, amount) {
    Year currentYear = renter
        .records![renter.records!.length - 1]; //last element of List<year>
    currentMonth = currentYear.months[currentYear.months.length - 1];

    List<Transaction> userTransactionList = currentMonth.transactions!;
    userTransactionList.add(Transaction(
        takenAmount: 45, timeStamp: DateTime.parse('2022-03-33 20:18:04Z')));
  }

  //returns list of transactions made by a user
  List<Transaction> listOfAllTransactions() {
    List<Transaction> transactionList = [];
    renter.records!.forEach(
      (year) => year.months.forEach(
        (monthDetail) {
          monthDetail.transactions!.forEach(
            (transaction) {
              transactionList.add(transaction);
            },
          );
        },
      ),
    );
    return transactionList;
  }
}