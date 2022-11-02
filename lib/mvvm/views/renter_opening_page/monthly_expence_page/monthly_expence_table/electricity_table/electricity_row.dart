import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity_table/alert_icon.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/purpose_title.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity_table/bill_loading_indicator.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

class ElectricityRow extends StatelessWidget {
  const ElectricityRow({
    super.key,
    required double fontSize,
  }) : _fontSize = fontSize;

  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    FlatViewModel viewModel = Provider.of<FlatViewModel>(context);
    double? prevReading = viewModel.selectedFlat?.previousMeterReading;
    double? presentReading = viewModel.selectedFlat?.presentMeterReading;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(
          titleIcon: AppIcons.electricityUrl,
          title: 'বিদ্যুৎ',
          widget: prevReading == null
              ? AlertIcon(
                  unitType: UnitType.previous,
                )
              : presentReading == null
                  ? AlertIcon(unitType: UnitType.previous)
                  : const SizedBox(),
        ),
        viewModel.isLoading
            ? billLoadingIndocator
            : Text(
                Formatter.toBn(
                    value: context.read<FlatViewModel>().electricBill ?? 0),
                style: TextStyle(fontSize: _fontSize),
              ),
      ],
    );
  }
}
