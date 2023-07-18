import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/modules/flats/provider/selected.flat.provider.dart';

import '../components/table_widgets.dart';
import 'alert_icon.dart';

// ignore: must_be_immutable
class ElectricityBillRow extends ConsumerWidget {
  ElectricityBillRow({
    super.key,
    // required this.showAlert,
    required this.prevReading,
    required this.presentReading,
    required this.bill,
    // required this.isLoading,
  });

  // final bool showAlert;
  final double? prevReading;
  // final bool isLoading;
  final double? presentReading;
  String bill;
  final double _fontSize = 16;

  bool showPresentReadingAlert = false;
  bool showPreviousReadingAlert = false;

  @override
  Widget build(BuildContext context, ref) {
    Flat? flat = ref.watch(selectedFlatProvider);
    if (flat != null) {
      if (flat.presentMeterReading == null) {
        showPresentReadingAlert = true;
      }
      if (flat.previousMeterReading == null) {
        showPreviousReadingAlert = true;
      }
      if (flat.renter != null) {
        // if (Formatter.toYearMonth(flat.renter!.entryDate) ==
        //     Formatter.toYearMonth(DateTime.now())) {
        showPresentReadingAlert = false;
        // }
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(
            titleIcon: AssetPath.electricityUrl,
            title: 'বিদ্যুৎ',
            widget: showPreviousReadingAlert
                ? AlertIcon(
                    unitType: UnitType.previous,
                  )
                : showPresentReadingAlert
                    ? AlertIcon(unitType: UnitType.present)
                    : const SizedBox.shrink()),
        // getPurposeTitle(
        //   titleIcon: AppIcons.electricityUrl,
        //   title: 'বিদ্যুৎ',
        //   widget: showAlert
        //       ? prevReading == null
        //           ? AlertIcon(
        //               unitType: UnitType.previous,
        //             )
        //           : presentReading == null
        //               ? AlertIcon(unitType: UnitType.present)
        //               : const SizedBox.shrink()
        //       : const SizedBox.shrink(),
        // ),
        Text(
          bill,
          style: TextStyle(fontSize: _fontSize),
        ),
      ],
    );
  }
}
