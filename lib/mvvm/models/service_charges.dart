class ServiceCharge {
  String purpose;
  double amount;

  ServiceCharge({required this.purpose, required this.amount});

  Map<String, dynamic> toJson() => {
        'purpose': purpose,
        'amount': amount,
      };
  static ServiceCharge fromJson(Map<String, dynamic> json) => ServiceCharge(
      purpose: json['purpose'] ?? '',
      amount: double.parse(json['amount'].toString()));
}
