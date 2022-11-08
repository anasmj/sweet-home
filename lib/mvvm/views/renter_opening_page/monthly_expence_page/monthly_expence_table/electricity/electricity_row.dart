import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/loading_indicator.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity/alert_icon.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/purpose_title.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

class ElectricityRow extends StatelessWidget {
  const ElectricityRow({
    super.key,
    required double fontSize,
  }) : _fontSize = fontSize;

  final double _fontSize;

  //TODO: should update in real time
  @override
  Widget build(BuildContext context) {
    FlatViewModel viewModel = Provider.of<FlatViewModel>(context);
    double? prevReading = viewModel.userFlat?.previousMeterReading;
    double? presentReading = viewModel.selectedFlat?.presentMeterReading;
    bool showAlert = prevReading == null || presentReading == null;
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
