import 'package:flutter/material.dart';
import 'package:sweet_home/src/components/edit.modal.sheet/edit_modal_sheet.dart';
import 'package:sweet_home/src/constants/constants.dart';

import '../app.widgets/app.widgets.dart';

// ignore: must_be_immutable
class OptionTile extends StatelessWidget {
  OptionTile({
    super.key,
    this.leadingIcon,
    this.customIcon,
    required this.sheetTitle,
    required this.subTitle,
    this.isDouble = false,
    this.isInt = false,
    this.validationFunciton,
    this.isNumeric = true,
    this.assetUrl,
    this.textFieldContent,
    this.isThreeLine = false,
  });
  // Home home;
  bool isThreeLine;
  IconData? leadingIcon;
  String sheetTitle, subTitle;
  bool isDouble, isInt;
  String? Function(String?)? validationFunciton;
  bool isNumeric;
  String? assetUrl;

  dynamic textFieldContent;
  Icon? customIcon;

  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: isThreeLine,
      onTap: () {
        AppWidget.getModalSheet(
          context: context,
          modalSheetContent: EditModalSheet(
            scope: Scope.home,
            sheetTitle: sheetTitle,
            onUpdated: () async {
              Navigator.pop(context);
            },
            isNumeric: isNumeric,
            isDouble: isDouble,
            isInt: isInt,
            validationFunciton: validationFunciton,
          ),
        );
      },
      leading: Icon(leadingIcon, color: colorInLightMode),
      title: Text(sheetTitle),
      subtitle: Text(
        subTitle.toString(),
        style: TextStyle(
          color: colorInLightMode,
        ),
      ),
    );
  }
  //vor falt list
}
