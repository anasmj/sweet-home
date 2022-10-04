class TransactionPrev {
  String? transactionPrevBy;
  DateTime timeStamp;
  double takenAmount;
  double? payable;
  bool isAdvance;
  double? due;

  TransactionPrev({
    required this.timeStamp,
    required this.takenAmount,
    this.transactionPrevBy, //TODO: make it required
    this.due,
    this.isAdvance = false,
  });
}
