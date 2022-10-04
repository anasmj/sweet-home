class RenterTransaction {
  String paidBy;
  double amount;
  DateTime time;
  RenterTransaction(
      {required this.paidBy, required this.amount, required this.time});
  Map<String, dynamic> toJson() => {
        'paidBy': paidBy,
        'amount': amount,
        'time': time.toIso8601String(),
      };
  static RenterTransaction fromJson(Map<String, dynamic> json) =>
      RenterTransaction(
        paidBy: json['paidBy'] ?? '',
        amount: json['amount'],
        time: DateTime.parse(json['time']),
      );
}
