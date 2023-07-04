import 'package:sweet_home/src/model/renter.dart';

class RenterTransaction {
  String paidBy;
  int amount;
  DateTime time;
  bool isAdvance;
  Renter? renter;
  RenterTransaction({
    required this.paidBy,
    required this.amount,
    required this.time,
    this.isAdvance = false,
    this.renter,
  });
  Map<String, dynamic> toJson() => {
        'paidBy': paidBy,
        'amount': amount,
        'time': time.toIso8601String(),
        'isAdvance': isAdvance,
        'renter': renter?.toJson()
      };
  static RenterTransaction fromJson(Map<String, dynamic> json) {
    final transaction = RenterTransaction(
      paidBy: json['paidBy'] ?? '',
      amount: json['amount'],
      time: DateTime.parse(json['time']),
      isAdvance: json['isAdvance'],
      renter: json['renter'] != null ? Renter.fromJson(json['renter']) : null,
    );

    return transaction;
  }

  @override
  String toString() =>
      'paid by: $paidBy, amount: $amount,time $time, isAdvance: $isAdvance, renter: $renter';
}
