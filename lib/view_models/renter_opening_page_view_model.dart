import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/models/home_model.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/services/record_services.dart';

import '../models/flat_model.dart';

class RenterOpeningViewModel extends ChangeNotifier {
  RenterOpeningViewModel(
      {this.currentHomeProvider, this.selectedFlatProvider}) {
    homeId = currentHomeProvider!.currentHome!.homeId;
    flatId = selectedFlatProvider!.selectedFlat!.flatName;
  }
  SelectedFlatProvider? selectedFlatProvider;
  CurrentHomeProvider? currentHomeProvider;
  double? _meterReading;
  String? homeId;
  String? flatId;
  double? get meterReading => _meterReading;
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
}
