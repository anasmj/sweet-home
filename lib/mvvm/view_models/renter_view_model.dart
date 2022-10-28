import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/transaction.dart';
import 'package:sweet_home/mvvm/services/transaction_service.dart';
import '../providers/current_home.dart';
import '../providers/selected_flat_provider.dart';
import '../services/record_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

//todo: INTIGRATE WITH TRANSACTION PROVIDER
class RenterViewModel extends ChangeNotifier {
  RenterViewModel({this.currentHomeProvider, this.selectedFlatProvider}) {
    _payerName = selectedFlatProvider?.selectedFlat?.renter?.renterName ?? '';
  }
  Response response = Response();
  Status _status = Status.empty;
  SelectedFlatProvider? selectedFlatProvider;
  CurrentHomeProvider? currentHomeProvider;
  double? paymentAmount;
  TextEditingController paymentController = TextEditingController();

  DateTime? _transactionTime;

  final GlobalKey<FormState> paymentKey = GlobalKey();

  late String _payerName;

  double? _meterReading;
  String? homeId;
  String? flatId;
  double? get meterReading => _meterReading;
  Widget uiWidget = const Center(
    child: CircularProgressIndicator(),
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  Status get status => _status;
  void setStatus(Status nweStatus) {
    _status = nweStatus;
    notifyListeners();
  }

  DateTime get transactionTime => _transactionTime ?? DateTime.now();
  void setTransactionTime(DateTime newTime) {
    _transactionTime = newTime;
    notifyListeners();
  }

  String get payerName => _payerName;
  void setPayerName(String value) {
    _payerName = value;
    notifyListeners();
  }

  set setMeterReading(double value) {
    _meterReading = value;

    if (homeId != null && flatId != null) {
      RecordService().getRecordCollectionRef(
        homeId: homeId!,
        flatName: flatId!,
      );
    }
    //update records in flat record
    notifyListeners();
  }

//!UPDATED
  Future<Response> addTransactionToRenter({required String homeId}) async {
    if (selectedFlatProvider?.selectedFlat != null) {
      String? flatName = selectedFlatProvider!.selectedFlat!.flatName;
      setLoading(true);
      setStatus(Status.loading);
      response = await TransactionService().addTransactionToRenter(
        homeId: homeId,
        flatId: flatName,
        transaction: RenterTransaction(
          paidBy: payerName,
          amount: double.parse(paymentController.text),
          time: transactionTime,
        ),
      );
      if (response.code == 200) {
        paymentController.clear();
        setStatus(Status.completed);
      }
      setLoading(false);
    } else {
      response.code = 201;
      response.body = 'no flat found';
      setStatus(Status.error);
    }

    return response;
  }
}
