import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/purpose_title.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

// ignore: must_be_immutable
class UtilityRow extends StatelessWidget {
  UtilityRow({super.key, this.viewModel});

  FlatViewModel? viewModel;
  @override
  Widget build(BuildContext context) {
    double? bill = viewModel?.utilityBill;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(titleIcon: AppIcons.otherUrl, title: 'অন্যান্য'),
        Text(Formatter.toBn(value: bill ?? 0.0)),
      ],
    );
  }
}
