import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';

import '../services/home_services.dart';

enum Status { loading, completed, empty, error }

class HomeListViewModel extends ChangeNotifier {
  HomeListViewModel({this.currentHome}) {
    if (currentHome != null) {
      getUserHomes();
    }
  }

  Response response = Response();
  Status _status = Status.empty;
  Home? currentHome;
  List<Home> _homeList = [];

  bool _isLoading = false;
  bool get loading => _isLoading;
  void setLoading(bool status) async {
    _isLoading = status;
    print(_isLoading);
    print(_status);
    notifyListeners();
  }

  Status get status => _status;
  void setStatus(Status status) async {
    _status = status;
    notifyListeners();
  }

  List<Home> get homeList => _homeList;
  set setHomeList(List<Home> homeList) {
    _homeList = homeList;
    print(_homeList);
    notifyListeners();
  }

  Future<void> getUserHomes() async {
    // setHomeList = [];
    setStatus(Status.loading);
    setLoading(true);
    Response response = await HomeCrud().getAllHomeVM();
    if (response.code != 200) {
      setStatus(Status.error);
    }
    List<Home> homes = response.content;
    if (homes.isEmpty) {
      setStatus(Status.empty);
    }
    setHomeList = response.content;
    setStatus(Status.completed);
    setLoading(false);
  }
  // Future<Home> getHomeInfo({required String homeId}) async {

  // }
}
