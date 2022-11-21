import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/record.dart';
import 'package:sweet_home/mvvm/services/record_services.dart';

class RecordViewModel extends ChangeNotifier {
  RecordViewModel({this.home, this.flat});
  Home? home;
  Flat? flat;
  bool _isLoading = false;
  get isLoading => _isLoading;
  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<List<Record>> getRecords() async {
    if (home == null || flat == null) return [];
    Iterable<Record> recordList = [];

    try {
      recordList = await RecordService()
          .getAll(homeId: home!.homeId, flatName: flat!.flatName);
    } catch (e) {
      //
    }
    return recordList.toList();
  }
}
