import 'package:flutter/material.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/utils/formatter.dart';

import '../components/table_widgets.dart';

// ignore: must_be_immutable
class UtilityRow extends StatelessWidget {
  const UtilityRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(titleIcon: AssetPath.otherUrl, title: 'অন্যান্য'),
        Text(Formatter.toBn(value: 0.0)),
      ],
    );
  }
}
