class Transaction {
  String? transactionBy;
  DateTime timeStamp;
  double takenAmount;
  double? payable;
  bool isAdvance;
  double? due; // it can be positive or negative value

  Transaction({
    required this.timeStamp,
    required this.takenAmount,
    this.transactionBy, //TODO: make it required
    this.due,
    this.isAdvance = false,
  });
}
