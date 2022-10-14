import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/service_charges.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/services/service_charge_service.dart';

enum Status { loading, completed, empty, error }

class ServiceChargeListViewModel extends ChangeNotifier {
  Response response = Response();
  ServiceChargeListViewModel({this.homeProvider}) {
    setChargeList([]);
    readAllServiceCharges();
  }
  Status _status = Status.empty;
  CurrentHomeProvider? homeProvider;
  List<ServiceCharge> _serviceChargeList = [];

  Status get status => _status;
  setStatus(Status status) async {
    _status = status;
    notifyListeners();
  }

  List<ServiceCharge> get chargeList => _serviceChargeList;
  setChargeList(List<ServiceCharge> chargeList) {
    _serviceChargeList = chargeList;
  }

  Future<void> readAllServiceCharges() async {
    if (homeProvider!.currentHome != null) {
      setStatus(Status.loading);
      Response response = await ServiceChargeService()
          .readHomeServiceCharge(homeId: homeProvider!.currentHome!.homeId);
      if (response.code != 200) {
        setStatus(Status.error);
      }
      setChargeList(response.content as List<ServiceCharge>);

      if (_serviceChargeList.isEmpty) {
        setStatus(Status.empty);
      } else {
        setStatus(Status.completed);
      }
    }
  }

  //add new service charge
  Future<Response> addNewServiceCharge(
      {required String title, required double amount}) async {
    if (homeProvider!.currentHome != null) {
      response = await ServiceChargeService().addNweServiceCharge(
          homeId: homeProvider!.currentHome!.homeId,
          serviceCharge: ServiceCharge(purpose: title, amount: amount));
    } else {
      response.code = 301;
    }

    return response;
  }
}
