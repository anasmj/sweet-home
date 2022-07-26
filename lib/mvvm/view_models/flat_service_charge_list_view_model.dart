import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/utility.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/services/utility_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

import 'flat_list_view_model.dart';
// import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';

//! this class isnt being used because service cherge for individual flat
//! isn't seem to be changed in for an unknown reason. For now i've decided
//! to make home service charge and flat service charge be the same.
//! user can make CRUT operation through > drawer-> your home -> others
class FlatServiceChargeListViewModel extends ChangeNotifier {
  Response response = Response();
  FlatServiceChargeListViewModel(
      {this.homeProvider, this.flatListVM, this.selectedFlatProvider});
  final Scope _scope = Scope.flat;
  CurrentHomeProvider? homeProvider;
  SelectedFlatProvider? selectedFlatProvider;
  FlatListViewModel? flatListVM;

  TextEditingController chargeEditingController = TextEditingController();
  GlobalKey<FormState> chargeEditingFormKey = GlobalKey();
  Status _status = Status.empty;
  List<Utility> _serviceChargeList = [];

  Status get status => _status;
  setStatus(Status status) async {
    _status = status;
    notifyListeners();
  }

  List<Utility> get serviceChargeList => _serviceChargeList;
  setChargeList(List<Utility> chargeList) {
    _serviceChargeList = chargeList;
  }

  Utility? _selectedServiceCharge;
  Utility? get selectedServiceCharge => _selectedServiceCharge;
  set setServiceCharge(Utility? charge) => _selectedServiceCharge = charge;
  //READ
  Future<void> readServiceCharges() async {
    String? homeId = homeProvider?.currentHome?.homeId;

    String? flatName = selectedFlatProvider?.selectedFlat?.flatName;
    if (flatName == null) return;
    if (homeId == null) return;
    setStatus(Status.loading);
    Response response = await UtilityServices()
        .readUtilities(scope: _scope, homeId: homeId, flatId: flatName);
    if (response.code != 200) {
      setStatus(Status.error);
      return;
    }
    setChargeList(response.content);

    if (_serviceChargeList.isEmpty) {
      setStatus(Status.empty);
    } else {
      setStatus(Status.completed);
    }
  }

  //add new service charge
  Future<Response> addNewServiceCharge(
      {required String title, required double amount}) async {
    List<Flat>? flatList = flatListVM?.flatList;
    if (homeProvider!.currentHome != null) {
      response = await UtilityServices().addNewUtility(
          homeId: homeProvider!.currentHome!.homeId,
          serviceCharge: Utility(purpose: title, amount: amount));
      if (flatList!.isNotEmpty) {
        String? homeId = homeProvider?.currentHome?.homeId;
        if (homeId != null) {
          try {
            for (var flat in flatList) {
              FlatService().updateFlat(
                  homeId: homeId,
                  flatName: flat.flatName,
                  fieldName: 'serviceCharges',
                  newValue: Utility(purpose: title, amount: amount));
            }
            response.code = 200;
          } catch (e) {
            response.code = 201;
            response.body = e.toString();
          }
        }
      }
    } else {
      response.code = 301;
    }

    return response;
  }

  //delete a service charge
  Future<Response> deleteServiceCharge({required Utility serviceCharge}) async {
    String? flatName = selectedFlatProvider?.selectedFlat?.flatName;
    List<Flat>? flatList = flatListVM?.flatList;
    String? id = homeProvider?.currentHome?.homeId;
    if (id == null) {
      response.code = 404;
      response.body = 'home not found';
    } else {
      response = await UtilityServices().deleteUtility(
        homeId: homeProvider!.currentHome!.homeId,
        flatId: flatName,
        scope: Scope.flat,
        serviceCharge: serviceCharge,
      );
      if (flatList!.isNotEmpty) {
        String? homeId = homeProvider?.currentHome?.homeId;
        if (homeId != null) {
          try {
            for (var flat in flatList) {
              FlatService().updateFlat(
                homeId: homeId,
                flatName: flat.flatName,
                fieldName: 'serviceCharges',
                newValue: serviceCharge,
                removeServiceCharge: true,
              );
            }
            response.code = 200;
          } catch (e) {
            response.code = 201;
            response.body = e.toString();
          }
        }
      }
      await readServiceCharges();
    }

    return response;
  }

  Future<Response?> updateHomeServiceCharge(
      {required Utility oldObj, required Utility newObj}) async {
    String? homeId = homeProvider?.currentHome?.homeId;
    if (homeId != null) {
      response = await UtilityServices().updateUtility(
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
