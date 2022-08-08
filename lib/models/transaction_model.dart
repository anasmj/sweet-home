class Transaction {
  DateTime transactionDate;
  double takenAmount;
  double? due;

  Transaction(
      {required this.transactionDate, required this.takenAmount, this.due});
}
