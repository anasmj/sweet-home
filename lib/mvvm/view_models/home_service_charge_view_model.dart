import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/utility.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/services/utility_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';

class HomeServiceChargeListViewModel extends ChangeNotifier {
  Response response = Response();
  HomeServiceChargeListViewModel({this.currentHomeProvider}) {
    // setChargeList([]);
    homeId = currentHomeProvider?.currentHome?.homeId;
    readServiceCharges();
  }
  final Scope _scope = Scope.home;

  FlatListViewModel? flatListVM;
  CurrentHomeProvider? currentHomeProvider;
  bool _isLoading = false;

  String? homeId;

  TextEditingController chargeEditingController = TextEditingController();
  GlobalKey<FormState> chargeEditingFormKey = GlobalKey();
  Status _status = Status.empty;

  List<Utility> _serviceChargeList = [];

  Status get status => _status;
  setStatus(Status status) async {
    _status = status;
  }

  bool get isLoading => _isLoading;
  void setLoading(bool loading) {
    _isLoading = loading;
    // notifyListeners();
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
    if (homeId == null) return;
    // setStatus(Status.loading);
    setLoading(true);
    Response response =
        await UtilityServices().readUtilities(homeId: homeId!, scope: _scope);

    if (response.code != 200) {
      setStatus(Status.error);
    } else {
      setChargeList(response.content);
    }
    setLoading(false);
  }

  //add new service charge
  Future<Response> addNewServiceCharge(
      {required String title, required double amount}) async {
    if (homeId != null) {
      //returning resopnse
      return await UtilityServices().addNewUtility(
          homeId: homeId!,
          serviceCharge: Utility(purpose: title, amount: amount));
    } else {
      response.code = 231;
      response.body = 'home id is not found';
      return response;
    }
  }
  //! if flats has their individul utility charges
  // Future<Response> addNewServiceCharge(
  //     {required String title, required double amount}) async {
  //   List<Flat>? flatList = flatListVM?.flatList;
  //   if (homeId != null) {
  //     response = await ServiceChargeService().addNweServiceCharge(
  //         homeId: homeId!,
  //         serviceCharge: ServiceCharge(purpose: title, amount: amount));
  //     if (flatList!.isNotEmpty) {
  //       if (homeId != null) {
  //         try {
  //           for (var flat in flatList) {
  //             FlatService().updateFlat(
  //                 homeId: homeId!,
  //                 flatName: flat.flatName,
  //                 fieldName: 'serviceCharges',
  //                 newValue: ServiceCharge(purpose: title, amount: amount));
  //           }
  //           response.code = 200;
  //         } catch (e) {
  //           response.code = 201;
  //           response.body = e.toString();
  //         }
  //       }
  //     }
  //   } else {
  //     response.code = 301;
  //   }

  //   return response;
  // }

  //delete a service charge
  Future<Response> deleteServiceCharge({required Utility serviceCharge}) async {
    if (homeId == null) {
      response.code = 404;
      response.body = 'home not found';
    } else {
      response = await UtilityServices().deleteUtility(
        homeId: homeId!,
        serviceCharge: serviceCharge,
        scope: Scope.home,
      );
      // if (flatList!.isNotEmpty) {
      //   if (homeId != null) {
      //     try {
      //       for (var flat in flatList) {
      //         FlatService().updateFlat(
      //           homeId: homeId!,
      //           flatName: flat.flatName,
      //           fieldName: 'serviceCharges',
      //           newValue: serviceCharge,
      //           removeServiceCharge: true,
      //         );
      //       }
      //       response.code = 200;
      //     } catch (e) {
      //       response.code = 201;
      //       response.body = e.toString();
      //     }
      //   }
      // }
      await readServiceCharges();
    }

    return response;
  }

  Future<Response?> updateHomeServiceCharge(
      {required Utility oldObj, required Utility newObj}) async {
    if (homeId != null) {
      response = await UtilityServices().updateUtility(
        homeId: homeId!,
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
