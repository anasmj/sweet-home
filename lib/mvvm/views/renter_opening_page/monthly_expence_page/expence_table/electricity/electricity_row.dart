import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';

import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/expence_table/components/table_widgets.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/expence_table/electricity/alert_icon.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

// ignore: must_be_immutable
class ElectricityBillRow extends StatelessWidget {
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
  Widget build(BuildContext context) {
    Flat? flat = context.watch<SelectedFlatProvider>().selectedFlat;
    if (flat != null) {
      if (flat.presentMeterReading == null) {
        showPresentReadingAlert = true;
      }
      if (flat.previousMeterReading == null) {
        showPreviousReadingAlert = true;
      }
      if (flat.renter != null) {
        if (Formatter.toYearMonth(flat.renter!.entryDate) ==
            Formatter.toYearMonth(DateTime.now())) {
          showPresentReadingAlert = false;
        }
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(
            titleIcon: AppIcons.electricityUrl,
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
