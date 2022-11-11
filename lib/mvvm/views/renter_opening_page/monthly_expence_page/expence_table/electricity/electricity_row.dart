import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/expence_table/components/table_widgets.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/expence_table/electricity/alert_icon.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

// ignore: must_be_immutable
class ElectricityBillRow extends StatelessWidget {
  ElectricityBillRow({
    super.key,
    required this.showAlert,
    required this.prevReading,
    required this.presentReading,
    required this.bill,
    // required this.isLoading,
  });

  final bool showAlert;
  final double? prevReading;
  // final bool isLoading;
  final double? presentReading;
  String bill;
  final double _fontSize = 16;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(
          titleIcon: AppIcons.electricityUrl,
          title: 'বিদ্যুৎ',
          widget: showAlert
              ? prevReading == null
                  ? AlertIcon(
                      unitType: UnitType.previous,
                    )
                  : presentReading == null
                      ? AlertIcon(unitType: UnitType.present)
                      : const SizedBox.shrink()
              : const SizedBox.shrink(),
        ),
        Text(
          bill,
          style: TextStyle(fontSize: _fontSize),
        ),
      ],
    );
  }
}
