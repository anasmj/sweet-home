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
  TextEditingController chargeEditingController = TextEditingController();
  GlobalKey<FormState> chargeEditingFormKey = GlobalKey();
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

  ServiceCharge? _selectedServiceCharge;
  ServiceCharge? get selectedServiceCharge => _selectedServiceCharge;
  set setServiceCharge(ServiceCharge? charge) =>
      _selectedServiceCharge = charge;

  Future<void> readAllServiceCharges() async {
    setStatus(Status.loading);
    String? homeId = homeProvider?.currentHome?.homeId;
    if (homeId != null) {
      Response response =
          await ServiceChargeService().readHomeServiceCharge(homeId: homeId);
      if (response.code != 200) {
        setStatus(Status.error);
        return;
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

  //delete a service charge
  Future<Response> deleteServiceCharge(
      {required ServiceCharge serviceCharge}) async {
    String? id = homeProvider?.currentHome?.homeId;
    if (id == null) {
      response.code = 404;
      response.body = 'not found';
    } else {
      response = await ServiceChargeService().deleteServiceCharge(
          homeId: homeProvider!.currentHome!.homeId,
          serviceCharge: serviceCharge);
      await readAllServiceCharges();
    }

    return response;
  }

  Future<Response?> updateServiceCharge(
      {required ServiceCharge oldObj, required ServiceCharge newObj}) async {
    String? homeId = homeProvider?.currentHome?.homeId;
    if (homeId != null) {
      response = await ServiceChargeService().updateServiceCharge(
        homeId: homeId,
        oldServiceCharge: oldObj,
        newServiceCharge: newObj,
      );
    }
    if (homeId == null) {
      response.code = 202;
      response.body = 'no home id found';
    }
    return response;
  }
}
