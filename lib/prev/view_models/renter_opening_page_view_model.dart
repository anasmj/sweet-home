import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/prev/models/home_model.dart';

import '../models/flat_model.dart';
import '../../mvvm/providers/current_home.dart';
import '../providers/flat_info_provider.dart';
import '../services/record_services.dart';

class RenterOpeningViewModel extends ChangeNotifier {
  RenterOpeningViewModel({this.currentHomeProvider, this.selectedFlatProvider});

  SelectedFlatProvider? selectedFlatProvider;
  CurrentHomeProvider? currentHomeProvider;
  double? _meterReading;
  String? homeId;
  String? flatId;
  double? get meterReading => _meterReading;
  Widget uiWidget = const Center(
    child: CircularProgressIndicator(),
  );
  void printSomething() {
    print(currentHomeProvider!.currentHome!.homeName);
  }

  set setMeterReading(double value) {
    _meterReading = value;

    if (homeId != null && flatId != null) {
      RecordService().getRecordCollectionRef(
        homeId: homeId!,
        flatName: flatId!,
      );
    }
    //update records in flat record
    notifyListeners();
  }

  Widget showWidget() {
    return Center(
      child: Text('hello'),
    );
  }
}
