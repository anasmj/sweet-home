import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';

import 'home_info_sheet_content.dart';

// ignore: must_be_immutable
class OptionTile extends StatelessWidget {
  OptionTile({
    super.key,
    required this.home,
    this.leadingIcon,
    required this.title,
    required this.subTitle,
    this.isDouble = false,
    this.isInt = false,
    this.validationFunciton,
    this.isNumeric = true,
    this.isTappable = true,
    this.assetUrl,
  });
  Home home;
  IconData? leadingIcon;
  String title, subTitle;
  bool isDouble, isInt;
  String? Function(String?)? validationFunciton;
  bool isNumeric;
  String? assetUrl;
  bool isTappable;

  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return ListTile(
      onTap: !isTappable
          ? null
          : () {
              AppWidget.getModalSheet(
                  context: context,
                  modalSheetContent: HomeInfoModalContent(
                    home: home,
                    title: title,
                    isNumeric: isNumeric,
                    isDouble: isDouble,
                    isInt: isInt,
                  ));
            },
      leading:
          Icon(leadingIcon, color: isDark ? colorInDarkMode : colorInLightMode),
      title: Text(title),
      subtitle: Text(
        subTitle.toString(),
        style: TextStyle(
          color: isDark ? colorInDarkMode : colorInLightMode,
        ),
      ),
    );
  }
}
