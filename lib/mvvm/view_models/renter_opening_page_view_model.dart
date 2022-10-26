import 'package:flutter/material.dart';
import '../providers/current_home.dart';
import '../providers/selected_flat_provider.dart';
import '../services/record_services.dart';

//todo: INTIGRATE WITH TRANSACTION PROVIDER
class RenterOpeningViewModel extends ChangeNotifier {
  RenterOpeningViewModel(
      {this.currentHomeProvider, this.selectedFlatProvider}) {
    _payerName = selectedFlatProvider?.selectedFlat?.renter?.renterName ?? '';
  }

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

  Widget showWidget() {
    return const Center(
      child: Text('hello'),
    );
  }
}
