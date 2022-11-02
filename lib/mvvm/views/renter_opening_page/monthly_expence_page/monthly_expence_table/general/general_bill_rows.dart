import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/purpose_title.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

const double _fontSize = 16;

Row flatRentRow(Flat flat) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getPurposeTitle(titleIcon: AppIcons.homeUrl, title: 'ভাড়া'),
      Text(
        Formatter.toBn(value: flat.flatRentAmount),
        style: const TextStyle(fontSize: _fontSize),
      ),
    ],
  );
}

Row gasBillRow(Flat flat) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getPurposeTitle(titleIcon: AppIcons.flameUrl, title: 'গ্যাস'),
      Text(
        Formatter.toBn(value: flat.flatGasBill),
        style: const TextStyle(fontSize: _fontSize),
      ),
    ],
  );
}

Row waterBillRow(Flat flat) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getPurposeTitle(titleIcon: AppIcons.waterTapUrl, title: 'পানি'),
      Text(
        Formatter.toBn(value: flat.flatWaterBill),
        style: const TextStyle(fontSize: _fontSize),
      ),
    ],
  );
}
