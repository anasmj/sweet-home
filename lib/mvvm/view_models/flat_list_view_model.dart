import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/repositories/flat_services.dart';
import 'package:sweet_home/prev/models/response.dart';

import '../models/home_model.dart';

class FlatListViewModel extends ChangeNotifier {
  Home? currentHome;
  FlatListViewModel({this.currentHome}) {
    configureFltas(currentHome?.homeId);
  }
  bool _isLoading = false;
  List<Flat> _flatList = [];

  bool _hasError = false;
  bool get hasError => _hasError;
  set setError(bool error) {
    _hasError = true;
  }

  get isLoading => _isLoading;
  setLoading(bool status) async {
    _isLoading = status;
    notifyListeners();
  }

  List<Flat> get flatList => _flatList;
  setFlatList(List<Flat> flatList) {
    _flatList = flatList;
    notifyListeners();
  }

  void configureFltas(String? homeId) async {
    setFlatList([]);

    late Response response;

    if (homeId == null) setFlatList([]);
    setLoading(true);
    if (homeId != null) {
      response = await FlatService().getAllFlatsForVm(homeId: homeId);
    }

    if (response.code == 200) {
      setFlatList(response.content as List<Flat>);
    }
    if (response.code != 200) {}
    setLoading(false);
  }
}
