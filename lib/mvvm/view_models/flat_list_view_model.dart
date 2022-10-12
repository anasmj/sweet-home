import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';

import '../models/home_model.dart';

class FlatListViewModel extends ChangeNotifier {
  Response response = Response();

  Home? currentHome;
  FlatListViewModel({this.currentHome}) {
    configureFltas(currentHome?.homeId);
    _flatList = [];
  }
  bool _isLoading = false;
  late List<Flat> _flatList;

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

    if (homeId != null) {
      setLoading(true);
      response = await FlatService().getAllFlatsForVm(homeId: homeId);
    }

    if (response.code == 200) {
      setFlatList(response.content as List<Flat>);
    }
    if (response.code != 200) {}
    setLoading(false);
  }
}
