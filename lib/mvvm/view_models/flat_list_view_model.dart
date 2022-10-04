import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/prev/models/flat_model.dart';
import 'package:sweet_home/mvvm/repositories/flat_services.dart';
import 'package:sweet_home/prev/models/response.dart';

import '../../prev/models/home_model.dart';

class FlatListViewModel extends ChangeNotifier {
  Home? currentHome;
  FlatListViewModel({this.currentHome}) {
    getFltas(currentHome?.homeId);
  }
  bool _isLoading = false;
  List<Flat> _flatList = [];

  get isLoading => _isLoading;
  setLoading(bool status) async {
    _isLoading = status;
    notifyListeners();
  }

  List<Flat> get flatList => _flatList;
  setFlatList(List<Flat> flatList) {
    _flatList = flatList;
  }

  getFltas(String? homeId) async {
    Response response;
    if (homeId == null) return _flatList;
    response = await FlatService().getAllFlatsForVm(homeId: homeId);

    if (response.code == 200) {
      print('flats found');
    }
    if (response.code != 200) {
      print('error occured');
    }
  }
}
