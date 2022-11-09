import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/table_widgets.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity/alert_icon.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

class ElectricityBillRow extends StatelessWidget {
  ElectricityBillRow({
    super.key,
    required this.showAlert,
    required this.prevReading,
    required this.presentReading,
    required this.bill,
    // required this.isLoading,
    required double fontSize,
  }) : _fontSize = fontSize;

  final bool showAlert;
  final double? prevReading;
  // final bool isLoading;
  final double? presentReading;
  String bill;

  final double _fontSize;

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
