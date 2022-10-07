class RenterTransaction {
  String? transactionPrevBy;
  DateTime timeStamp;
  double takenAmount;
  double? payable;
  bool isAdvance;
  double? due;

  RenterTransaction({
    required this.timeStamp,
    required this.takenAmount,
    this.transactionPrevBy, //TODO: make it required
    this.due,
    this.isAdvance = false,
  });
}
