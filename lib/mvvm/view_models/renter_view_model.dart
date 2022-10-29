import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/transaction.dart';
import 'package:sweet_home/mvvm/services/renter_service.dart';
import 'package:sweet_home/mvvm/services/transaction_service.dart';
import '../providers/current_home.dart';
import '../providers/selected_flat_provider.dart';
import '../services/record_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

//* CONTAINS ALL LOGIC RELATED TO RENTER
class RenterViewModel extends ChangeNotifier {
  RenterViewModel({this.currentHomeProvider, this.selectedFlatProvider}) {
    _payerName = selectedFlatProvider?.selectedFlat?.renter?.renterName ?? '';
    _previousReading =
        selectedFlatProvider?.selectedFlat?.previousMeterReading ?? 0;
    _currentReading = selectedFlatProvider?.selectedFlat?.currentMeterReading;
  }

  SelectedFlatProvider? selectedFlatProvider;
  CurrentHomeProvider? currentHomeProvider;

  Response response = Response();
  Status _status = Status.empty;
  double? paymentAmount;
  TextEditingController paymentController = TextEditingController();
  DateTime? _transactionTime;

  final GlobalKey<FormState> paymentKey = GlobalKey();
  final double kUnitPrice = 1;
  late String _payerName;

  double? _meterReading;
  String? homeId;
  String? flatId;

  double? _previousReading;
  double? _currentReading;

  set setCurrentReading(double reading) {
    _currentReading = reading;
    notifyListeners();
  }

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

  double? get totalBill {
    return selectedFlatProvider!.selectedFlat!.flatRentAmount +
        selectedFlatProvider!.selectedFlat!.flatGasBill +
        selectedFlatProvider!.selectedFlat!.flatWaterBill +
        electricBill;
  }

  double get electricBill {
    // if (previousReading != null && currentReading != null) {
    //   _usedUnit = currentReading! - previousReading!;
    //   return (currentReading! - previousReading!) * 0.7;
    // }
    return 0;
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
  Future<void> addTransactionToRenter({required String homeId}) async {
    if (selectedFlatProvider?.selectedFlat != null) {
      String? flatName = selectedFlatProvider!.selectedFlat!.flatName;

      setLoading(true);
      setStatus(Status.loading);
      try {
        double? accountBalance =
            selectedFlatProvider?.selectedFlat?.renter?.dueAmount;
        Response addResponse =
            await TransactionService().addTransactionToRenter(
                homeId: homeId,
                flatId: flatName,
                transaction: RenterTransaction(
                  paidBy: payerName,
                  amount: double.parse(paymentController.text),
                  time: transactionTime,
                ));

        //! transaciton will be deducted from dueAmount
        //! expences will be added to dueAmount
        double newBalance =
            accountBalance! - double.parse(paymentController.text);
        Response updateResponse = await RenterService().updateRenter(
          homeId: homeId,
          flatName: flatName,
          fieldName: 'dueAmount',
          newValue: newBalance,
        );

        if (addResponse.code == 200 && updateResponse.code == 200) {
          response.code = 200;
          response.body = 'transaction successfull';
        }
      } catch (e) {
        response.code = 203;
        response.body = 'transaction failed';
      }

      if (response.code == 200) {
        setTransactionTime(DateTime.now());
        paymentController.clear();
        setStatus(Status.completed);
      }
      setLoading(false);
    } else {
      // response.code = 201;
      // response.body = 'no flat found';
      setStatus(Status.error);
    }
  }
}
