import 'package:flutter/material.dart';
import 'package:sweet_home/src/constants/src/asset.path.dart';

import '../components/table_widgets.dart';

const double _fontSize = 16;

Row flatRentRow(String rent) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getPurposeTitle(titleIcon: AssetPath.homeUrl, title: 'ভাড়া'),
      Text(
        rent,
        style: const TextStyle(fontSize: _fontSize),
      ),
    ],
  );
}

Row gasBillRow(String gas) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getPurposeTitle(titleIcon: AssetPath.flameUrl, title: 'গ্যাস'),
      Text(
        gas,
        style: const TextStyle(fontSize: _fontSize),
      ),
    ],
  );
}

Row waterBillRow(String water) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getPurposeTitle(titleIcon: AssetPath.waterTapUrl, title: 'পানি'),
      Text(
        water,
        style: const TextStyle(fontSize: _fontSize),
      ),
    ],
  );
}
