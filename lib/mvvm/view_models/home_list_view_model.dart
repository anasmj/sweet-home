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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

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
    setLoading(true);
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
    }
    setLoading(false);
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
        .updateHomeField(homeId: id, field: fieldName, newValue: newValue);

    if (response.code == 200) {
      setStatus(Status.completed);
      await Future.delayed(const Duration(seconds: 2));
      setStatus(Status.empty);
    } else {
      setStatus(Status.error);
    }
    setLoading(false);
  }
}
