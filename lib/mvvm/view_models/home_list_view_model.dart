import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import '../services/home_services.dart';

class HomeListViewModel extends ChangeNotifier {
  bool shouldReload;
  HomeListViewModel({this.currentHomeProvider, this.shouldReload = true}) {
    if (currentHomeProvider == null) return;
    if (shouldReload) getUserHomes();
  }
  TextEditingController displayTextController = TextEditingController();
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  Response response = Response();
  Status _status = Status.empty;
  CurrentHomeProvider? currentHomeProvider;
  // Home? currentHome;
  List<Home> _homeList = [];

  Status get status => _status;
  setStatus(Status status) async {
    _status = status;
    notifyListeners();
  }

  List<Home> get homeList => _homeList;
  setHomeList(List<Home> homeList) {
    _homeList = homeList;
    // notifyListeners();
  }

  Future<void> getUserHomes() async {
    // setHomeList([]);
    setStatus(Status.loading);

    Response response = await HomeServices().getAllHomeVM();
    if (response.code != 200) {
      setStatus(Status.error);
      return;
    }

    setHomeList(response.content as List<Home>);

    if (_homeList.isEmpty) {
      currentHomeProvider!.setCurrentHome = null; //!fais attention'
      setHomeList([]);
      setStatus(Status.empty);
    } else {
      if (currentHomeProvider!.currentHome == null) {
        await currentHomeProvider?.setUserHome(userHomes: _homeList);
      }
      setStatus(Status.completed);
    }
  }

  Future<Response> deleteHome() async {
    if (currentHomeProvider!.currentHome != null) {
      String homeId = currentHomeProvider!.currentHome!.homeId;
      response = await HomeServices().deleteHome(homeId);
      if (response.code == 200) {
        await currentHomeProvider?.setUserHome();
      }
    }
    return response;
  }

  Future<void> updateField(
      {required String fieldName, required dynamic newValue}) async {
    String? id = currentHomeProvider?.currentHome?.homeId;
    if (id == null) return;
    setStatus(Status.loading);
    // setLoading(true);
    response = await HomeServices()
        .updatefield(homeId: id, field: fieldName, newValue: newValue);

    if (response.code == 200) {
      setStatus(Status.completed);
    } else {
      setStatus(Status.error);
    }
    // setLoading(false);
  }

  // Future<void> setUserHome() async {
  //   setStatus(Status.loading);
  //   Response homeRes = await HomeServices().getAllHomeVM();
  //   if (response.code != 200) return;
  //   List<Home> homeList = homeRes.content;
  //   if (homeList.isEmpty) {
  //     setStatus(Status.completed);
  //     return;
  //   }

  //   currentHomeProvider?.setCurrentHome = homeList.first;
  //   setStatus(Status.completed);
  // }
}
