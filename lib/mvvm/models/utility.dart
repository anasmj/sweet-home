class Utility {
  String purpose;
  double amount;

  Utility({required this.purpose, required this.amount});

  Map<String, dynamic> toJson() => {
        'purpose': purpose,
        'amount': amount,
      };
  static Utility fromJson(Map<String, dynamic> json) => Utility(
      purpose: json['purpose'] ?? '',
      amount: double.parse(json['amount'].toString()));
}
