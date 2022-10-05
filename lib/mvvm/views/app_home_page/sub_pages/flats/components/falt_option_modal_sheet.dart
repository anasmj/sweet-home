import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../prev/providers/theme_provider.dart';

RoundedRectangleBorder getModalSheetStyle() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );
}

Future flatOptionModalSheet(
    {required BuildContext context, required bool isDark}) {
  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;

  return showModalBottomSheet(
      shape: getModalSheetStyle(),
      backgroundColor: isDark ? modalSheetBgDark : modalSheetBgLight,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 300,
        );
      });
}
