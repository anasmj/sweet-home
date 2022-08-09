class Transaction {
  DateTime transactionDate;
  double takenAmount;
  bool isAdvance;
  double? due;

  Transaction(
      {required this.transactionDate,
      required this.takenAmount,
      this.due,
      this.isAdvance = false});
}
