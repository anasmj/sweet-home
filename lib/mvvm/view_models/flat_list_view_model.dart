import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

class FlatListViewModel extends ChangeNotifier {
  FlatListViewModel({this.currentHome, this.selectedFlatProvider}) {
    homeId = currentHome?.homeId;
    selectedFlatName = selectedFlatProvider?.selectedFlat?.flatName;
    configureFltas();
    _flatList = [];
  }
  Response response = Response();
  Home? currentHome;
  String? homeId;
  String? selectedFlatName;
  TextEditingController previousMeterController = TextEditingController();
  TextEditingController currentMeterController = TextEditingController();
  GlobalKey<FormState> meterReadingKey = GlobalKey();
  SelectedFlatProvider? selectedFlatProvider;

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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  bool _hasError = false;
  bool get hasError => _hasError;
  set setError(bool error) {
    _hasError = true;
  }

  List<Flat> get flatList => _flatList;
  setFlatList(List<Flat> flatList) {
    _flatList = flatList;
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

  Future<Response> updateCurrentMonthMeterReading() async {
    if (homeId != null && selectedFlatName != null) {
      response = await FlatService().updateFlat(
        homeId: homeId!,
        flatName: selectedFlatName!,
        fieldName: 'currentMeterReading',
        newValue: double.parse(currentMeterController.text),
        updateTime: DateTime.now(),
      );
      return response;
    } else {
      response.code = 201;
      response.body = 'failed';
      return response;
    }
  }

  Future<Response> updatePreviousMonthMeterReading() async {
    if (homeId != null && selectedFlatName != null) {
      // DateTime lastMonthDate =
      //     DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
      setLoading(true);
      response = await FlatService().updateFlat(
        homeId: homeId!,
        flatName: selectedFlatName!,
        fieldName: 'previousMeterReading',
        newValue: double.parse(previousMeterController.text),
        updateTime: DateTime.now(),
      );
      setLoading(false);
      return response;
    }
    response.code = 203;
    response.body = 'failed';
    return response;
  }
}
