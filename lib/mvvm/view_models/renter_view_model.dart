import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/transaction.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/services/record_services.dart';
import 'package:sweet_home/mvvm/services/renter_service.dart';
import 'package:sweet_home/mvvm/services/transaction_service.dart';
import 'package:sweet_home/mvvm/utils/fields.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import '../providers/current_home.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

//* CONTAINS ALL LOGIC RELATED TO RENTER
//TODO: clean up this class
class RenterViewModel extends ChangeNotifier {
  RenterViewModel({this.currentHomeProvider, this.flatViewModel}) {
    _payerName = flatViewModel?.userFlat?.renter?.renterName ?? '';
  }
  FlatViewModel? flatViewModel;
  CurrentHomeProvider? currentHomeProvider;

  Response response = Response();
  Status _status = Status.empty;
  bool _isLoading = false;

  double? paymentAmount;
  DateTime? _transactionTime;
  TextEditingController paymentController = TextEditingController();

  final GlobalKey<FormState> paymentKey = GlobalKey();
  late String _payerName;

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

  Future<void> addTransactionToRenter({required String homeId}) async {
    //! renterDue = renterDue + (monthlyDue-transactionAmount)
    //! expences will be added to monthlyDue
    // ignore: unused_local_variable
    Response transferResponse,
        monthlyDueUpdateResponse,
        updateRecordResponse,
        renterDueUpdateResponse;
    double transactionAmount = double.parse(paymentController.text);

    double monthlyDue = flatViewModel!.userFlat!.monthlyDue;
    double renterDue = flatViewModel?.userFlat?.renter?.renterDue ?? 0;

    double newMonthlyDue = monthlyDue - transactionAmount; //CAN BE NEGATIVE
    double newRenterDue = renterDue + newMonthlyDue;

    Flat flat = flatViewModel!.userFlat!;
    setLoading(true);
    setStatus(Status.loading);
    // print('monthlyDue: $monthlyDue');
    // print('renterDue: $renterDue');

    // print('transfer amount : $transactionAmount');
    // print('newMonthlyDue $newMonthlyDue');
    // print('newRenterDue : $newRenterDue');
    try {
      //*ADD TO TRANSACTIONS
      Response transferResponse =
          await TransactionService().addTransactionToRenter(
        homeId: homeId,
        flatId: flat.flatName,
        transaction: RenterTransaction(
          paidBy: payerName,
          amount: transactionAmount,
          time: transactionTime,
        ),
      );
      if (transferResponse.code != 200) {
        response.code = 320;
        response.body = 'transaction failed';
        return;
      }
      //*UPDATE MONTHLY DUE
      monthlyDueUpdateResponse = await FlatService().updateFlat(
          homeId: homeId,
          flatName: flat.flatName,
          fieldName: 'monthlyDue',
          newValue: newMonthlyDue);
      if (monthlyDueUpdateResponse.code != 200) {
        response.code = 320;
        response.body = 'monthly due update failed';
        return;
      }
      //*UPDATE CURRENT MONTH RECORD
      updateRecordResponse = await RecordService().updateRecord(
          homeId: homeId,
          flatName: flat.flatName,
          fieldName: 'monthlyDue',
          value: newMonthlyDue,
          datetime: DateTime.now());
      if (updateRecordResponse.code != 200) {
        response.code = 320;
        response.body = 'record update failed';
        return;
      }
      //*UPDATE RENTER DUE
      renterDueUpdateResponse =
          await updateRenter(field: 'dueAmount', value: newRenterDue);
      if (renterDueUpdateResponse.code != 200) {
        response.code = 320;
        response.body = 'renter due update failed';
        return;
      }
    } catch (e) {
      response.code = 203;
      response.body = 'transaction failed';
    }
    if (response.code == 200) {
      setTransactionTime(DateTime.now());
      //updating data
      paymentController.clear();
      setStatus(Status.completed);
    } else {
      // response.code = 201;
      response.body = 'error occured ';
      setStatus(Status.error);
    }
    setLoading(false);
  }

  Future<Response> updateRenter(
      {required String field, required dynamic value}) async {
    Response response = Response();
    String? homeId = currentHomeProvider?.currentHome?.homeId;
    String? flatName = flatViewModel?.userFlat?.flatName;
    if (homeId == null || flatName == null) {
      response.code = 233;
      response.body = 'home or flat is null';
    } else {
      response = await RenterService().updateRenter(
        homeId: homeId,
        flatName: flatName,
        fieldName: field,
        newValue: value,
      );
    }
    return response;
  }

  Future<bool> removeRenterFromFlat() async {
    String? homeId = currentHomeProvider?.currentHome?.homeId;
    String? flatName = flatViewModel?.userFlat?.flatName;
    double? presentReading = flatViewModel!.userFlat?.presentMeterReading;
    String previousMonthRecordId = Formatter().makeId(
        date: DateTime(
            DateTime.now().year, DateTime.now().month - 1, DateTime.now().day));

    bool flatUpdateStatus = false;
    bool isLastMonthRecordDeleted = false;
    if (homeId == null || flatName == null) return false;
    RenterService()
        .removeRenterFromFlat(homeId: homeId, flatId: flatName)
        .whenComplete(() async {
      // await FlatService()
      //     .updateMultiple(homeId: homeId, flatName: flatName, map: {
      //   FlatField.confirmDate: null,
      //   FlatField.due: 0.00,
      //   FlatField.previousReading: presentReading,
      //   FlatField.previousTime: DateTime.now().toIso8601String(),
      //   FlatField.presentReading: null,
      //   FlatField.presentTime: DateTime.now().toIso8601String(),
      // }).whenComplete(() async {
      //   isLastMonthRecordDeleted = await RecordService().deleteRecord(
      //       homeId: homeId,
      //       flatName: flatName,
      //       recordId: previousMonthRecordId);
      // });
    });

    return isLastMonthRecordDeleted;
  }
}
