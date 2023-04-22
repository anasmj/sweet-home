class RenterTransaction {
  String paidBy;
  double amount;
  DateTime time;
  bool isAdvance;
  RenterTransaction({
    required this.paidBy,
    required this.amount,
    required this.time,
    this.isAdvance = false,
  });
  Map<String, dynamic> toJson() => {
        'paidBy': paidBy,
        'amount': amount,
        'time': time.toIso8601String(),
        'isAdvance': isAdvance
      };
  static RenterTransaction fromJson(Map<String, dynamic> json) =>
      RenterTransaction(
        paidBy: json['paidBy'] ?? '',
        amount: json['amount'],
        time: DateTime.parse(json['time']),
        isAdvance: json['isAdvance'],
      );
}
