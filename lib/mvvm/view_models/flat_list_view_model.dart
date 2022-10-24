import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

class FlatListViewModel extends ChangeNotifier {
  Response response = Response();

  Home? currentHome;
  SelectedFlatProvider? selectedFlatProvider;
  FlatListViewModel({this.currentHome, this.selectedFlatProvider}) {
    configureFltas();
    _flatList = [];
  }
  // bool _isLoading = false;
  late List<Flat> _flatList;
  TextEditingController displayTextController = TextEditingController();
  GlobalKey<FormState> editFlatFormKey = GlobalKey<FormState>();

  Status _status = Status.loading;
  Status get status => _status;
  setStatus(Status status) async {
    _status = status;
    notifyListeners();
  }

  bool _hasError = false;
  bool get hasError => _hasError;
  set setError(bool error) {
    _hasError = true;
  }
  //delete afer being sure
  // get isLoading => _isLoading;
  // setLoading(bool status) async {
  //   _isLoading = status;
  //   notifyListeners();
  // }

  List<Flat> get flatList => _flatList;
  setFlatList(List<Flat> flatList) {
    _flatList = flatList;

    // notifyListeners();
  }

  Future<void> configureFltas() async {
    String? homeId = currentHome?.homeId;
    setFlatList([]);
    if (homeId == null) return;
    setStatus(Status.loading);

    response = await FlatService().getAllFlatsForVm(homeId: homeId);
    if (response.code != 200) {
      setStatus(Status.error);
      return;
    }
    setFlatList(response.content as List<Flat>);
    if (_flatList.isEmpty) setStatus(Status.empty);
    if (_flatList.isNotEmpty) setStatus(Status.completed);
  }

  Future<void> updateField({
    required String fieldName,
    required dynamic newValue,
    required String flatName,
  }) async {
    String? id = currentHome?.homeId;
    String? flatName = selectedFlatProvider?.selectedFlat?.flatName;

    if (id == null || flatName == null) return;
    setStatus(Status.loading);

    response = await FlatService().updateFlat(
      homeId: id,
      flatName: flatName,
      fieldName: fieldName,
      newValue: newValue,
    );

    if (response.code == 200) {
      setStatus(Status.completed);
    } else {
      setStatus(Status.error);
    }
  }
  //   setFlatList([]);
  //   if (homeId == null) return;

  //   // setLoading(true);
  //   response = await FlatService().getAllFlatsForVm(homeId: homeId);

  //   if (response.code == 200) {
  //     setFlatList(response.content as List<Flat>);
  //   }
  //   if (response.code != 200) {}
  //   // setLoading(false);
  // }
}
