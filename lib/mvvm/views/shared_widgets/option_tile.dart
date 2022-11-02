import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/home_crud_helper.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/edit_modal_sheet.dart';

// ignore: must_be_immutable
class OptionTile extends StatelessWidget {
  OptionTile({
    super.key,
    // required this.home,
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
    this.flatViewModel,
    this.homeListViewModel,
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

  FlatViewModel? flatViewModel;
  HomeListViewModel? homeListViewModel;

  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    if (homeListViewModel != null) {
      return ListTile(
        isThreeLine: isThreeLine,
        onTap: () {
          AppWidget.getModalSheet(
            context: context,
            modalSheetContent: EditModalSheet(
              scope: Scope.home,
              sheetTitle: sheetTitle,
              onUpdated: () async {
                if (!homeListViewModel!.editFormKey.currentState!.validate()) {
                  return;
                }

                Navigator.pop(context);

                await homeListViewModel!.updateField(
                  fieldName: getFirebaseFieldName(title: sheetTitle),
                  newValue: castToDbFieldValue(
                    value: homeListViewModel!.displayTextController.text,
                    isDouble: isDouble,
                    isInt: isInt,
                  ),
                );

                if (homeListViewModel!.status == Status.error) return;
                if (homeListViewModel!.status == Status.completed) {
                  homeListViewModel!.getUserHomes();
                  homeListViewModel!.displayTextController.clear();
                } else {
                  AppWidget.showSnackBarWithMsg(msg: 'আপডেট করা সম্ভব হয়নি');
                }
              },
              isNumeric: isNumeric,
              isDouble: isDouble,
              isInt: isInt,
              validationFunciton: validationFunciton,
              controller: homeListViewModel!.displayTextController,
              formKey: homeListViewModel!.editFormKey,
            ),
          );
        },
        leading: Icon(leadingIcon,
            color: isDark ? colorInDarkMode : colorInLightMode),
        title: Text(sheetTitle),
        subtitle: Text(
          subTitle.toString(),
          style: TextStyle(
            color: isDark ? colorInDarkMode : colorInLightMode,
          ),
        ),
      );
    }
    //vor falt list
    if (flatViewModel != null) {
      return ListTile(
        onTap: () {
          AppWidget.getModalSheet(
            context: context,
            modalSheetContent: EditModalSheet(
              scope: Scope.flat,
              sheetTitle: sheetTitle,
              onUpdated: () async {
                if (!flatViewModel!.editFlatFormKey.currentState!.validate()) {
                  return;
                }
                //TODO: keyboard needs to be dissapeared
                // FocusScope.of(context).unfocus();

                await flatViewModel!.updateField(
                  fieldName: getFirebaseFieldName(title: sheetTitle),
                  newValue: castToDbFieldValue(
                    value: flatViewModel!.displayTextController.text,
                    isDouble: isDouble,
                    isInt: isInt,
                  ),
                );

                if (flatViewModel!.status == Status.completed) {
                  flatViewModel!.displayTextController.clear();
                  await Future.delayed(const Duration(seconds: 2));
                  flatViewModel!.setStatus(Status.empty);
                } else {
                  AppWidget.showSnackBarWithMsg(
                    msg: 'আপডেট করা সম্ভব হয়নি',
                  );
                }
              },
              isNumeric: isNumeric,
              isDouble: isDouble,
              isInt: isInt,
              validationFunciton: validationFunciton,
              controller: flatViewModel!.displayTextController,
              formKey: flatViewModel!.editFlatFormKey,
            ),
          ).whenComplete(() {
            flatViewModel!.setStatus(Status.empty);
          });
        },
        leading: customIcon ??
            Icon(leadingIcon,
                color: isDark ? colorInDarkMode : colorInLightMode),
        title: Text(sheetTitle),
        subtitle: Text(
          subTitle.toString(),
          style: TextStyle(
            color: isDark ? colorInDarkMode : colorInLightMode,
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
