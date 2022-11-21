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
    Response transferResponse = Response();
    Response monthlyDueUpdateResponse = Response();
    Response updateRecordResponse = Response();
    Response renterDueUpdateResponse = Response();

    double transactionAmount = double.parse(paymentController.text);
    double monthlyDue = flatViewModel!.userFlat!.monthlyDue;
    double renterDue = flatViewModel?.userFlat?.renter?.renterDue ?? 0;

    double newRenterDue = renterDue + transactionAmount;

    double newMonthlyDue = monthlyDue - transactionAmount; //CAN BE NEGATIVE
    newRenterDue = renterDue + newMonthlyDue;

    Flat flat = flatViewModel!.userFlat!;
    setLoading(true);
    setStatus(Status.loading);
    // print('****previous****');

    // print('monthlyDue $monthlyDue');
    // print('renterDue : $renterDue\n\n');

    // print('after adding ৳$transactionAmount: ');
    // print('*************');
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
      //*UPDATE RENTER DUE
      renterDueUpdateResponse =
          await updateRenter(field: RenterField.due_, value: newRenterDue);
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
    } else {
      // response.code = 201;
      response.body = 'error occured ';
      setStatus(Status.error);
    }
    //*UPDATE MONTHLY DUE
    monthlyDueUpdateResponse = await FlatService().updateFlat(
        homeId: homeId,
        flatName: flat.flatName,
        fieldName: FlatField.due,
        newValue: newMonthlyDue);
    if (monthlyDueUpdateResponse.code != 200) {
      response.code = 320;
      response.body = 'monthly due update failed';
      return;
    }
    //*UPDATE PREVIOUS MONTH RECORD
    updateRecordResponse = await RecordService().updateRecord(
        homeId: homeId,
        flatName: flat.flatName,
        map: {
          // RecordField.monthlyDue: newMonthlyDue,

          // RecordField.renterDue: newRenterDue,
          RecordField.paid: transactionAmount,
        },
        recordDate: Formatter.previousDate);
    if (updateRecordResponse.code != 200 && updateRecordResponse.code != 201) {
      response.body = 'record update failed';
      return;
    }
    // print('transferResponse ${transferResponse.code}');
    // print('renterDueUpdateResponse ${renterDueUpdateResponse.code}');
    // print('monthlyDueUpdateResponse ${monthlyDueUpdateResponse.code}');
    // print('updateRecordResponse ${updateRecordResponse.code}');
    setLoading(false);
    setStatus(Status.completed);
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

  Future<Response> removeRenterFromFlat() async {
    String? homeId = currentHomeProvider?.currentHome?.homeId;
    String? flatName = flatViewModel?.userFlat?.flatName;
    double? presentReading = flatViewModel!.userFlat?.presentMeterReading;

    if (homeId == null || flatName == null) {
      response.code = 203;
      response.body = 'null found in homeId or FlatNam';
      return response;
    }
    await RenterService()
        .removeRenterFromFlat(homeId: homeId, flatId: flatName)
        .whenComplete(() async {
      await FlatService()
          .updateMultiple(homeId: homeId, flatName: flatName, map: {
        FlatField.confirmDate: null,
        FlatField.due: 0.00,
        FlatField.previousReading: presentReading,
        // FlatField.previousTime: DateTime.now().toIso8601String(),
        // FlatField.presentReading: null,
        FlatField.presentTime: null,
      }).whenComplete(() {
        RecordService().deleteRecord(
            homeId: homeId,
            flatName: flatName,
            recordId: Formatter.toYearMonth(Formatter.previousDate));
      });
      response.code = 200;
      response.body = 'ok';
    }).catchError((e) {
      response.code = 232;
      response.body = e.toString();
    });

    return response;
  }
}
