import 'package:flutter/cupertino.dart';

class TransactionProvider extends ChangeNotifier {
  String payerName = '';
  TextEditingController paymentController = TextEditingController();
  TextEditingController payerController = TextEditingController();
  String tempName = '';
  final GlobalKey<FormState> _paymentKey = GlobalKey();
  final GlobalKey<FormState> _payerKey = GlobalKey();

  GlobalKey<FormState> get paymentKey => _paymentKey;
  GlobalKey<FormState> get payerKey => _payerKey;
  DateTime transactionDateTime = DateTime.now();

  void setPayer(String value) {
    payerController.text = value;
    payerName = value;
    notifyListeners();
  }
}
