import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import '../services/home_services.dart';

enum Status { loading, completed, empty, error }

class HomeListViewModel extends ChangeNotifier {
  bool shouldReload;
  HomeListViewModel({this.currentHomeProvider, this.shouldReload = true}) {
    if (currentHomeProvider == null) return;
    if (shouldReload) getUserHomes();
  }

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
    notifyListeners();
  }

  Future<void> getUserHomes() async {
    // setHomeList([]);
    setStatus(Status.loading);

    Response response = await HomeServices().getAllHomeVM();
    if (response.code != 200) {
      setStatus(Status.error);
    }

    setHomeList(response.content as List<Home>);

    if (_homeList.isEmpty) {
      currentHomeProvider!.setCurrentHome = null; //!fais attention
      setStatus(Status.empty);
    } else {
      if (currentHomeProvider!.currentHome == null) {
        await currentHomeProvider!.setUserHome(userHomes: _homeList);
      }

      setStatus(Status.completed);
    }
  }

  Future onHomeDeleted() async {
    if (currentHomeProvider!.currentHome != null) {
      String homeId = currentHomeProvider!.currentHome!.homeId;
      response = HomeServices().deleteHome(homeId);
    }
    return response;
  }
}
