// import 'package:flutter/cupertino.dart';

// class TransactionProvider extends ChangeNotifier {
//   String _payerName = '';
//   TextEditingController paymentController = TextEditingController();
//   TextEditingController payerController = TextEditingController();

//   String get payerName => _payerName;
//   void setPayerName(String value) {
//     _payerName = value;
//     notifyListeners();
//   }

//   String tempName = '';
//   final GlobalKey<FormState> _paymentKey = GlobalKey();
//   final GlobalKey<FormState> _payerKey = GlobalKey();

//   GlobalKey<FormState> get paymentKey => _paymentKey;
//   GlobalKey<FormState> get payerKey => _payerKey;
//   DateTime transactionDateTime = DateTime.now();

//   void setPayer(String value) {
//     payerController.text = value;
//     _payerName = value;
//     notifyListeners();
//   }
// }
