import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/utils/home_crud_helper.dart';
import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/edit_sheet_content.dart';

import 'home_info_sheet_content.dart';

// ignore: must_be_immutable
class OptionTile extends StatelessWidget {
  OptionTile({
    super.key,
    required this.home,
    this.leadingIcon,
    required this.sheetTitle,
    required this.subTitle,
    this.isDouble = false,
    this.isInt = false,
    this.validationFunciton,
    this.isNumeric = true,
    this.isTappable = true,
    this.assetUrl,
    this.textFieldContent,
  });
  Home home;
  IconData? leadingIcon;
  String sheetTitle, subTitle;
  bool isDouble, isInt;
  String? Function(String?)? validationFunciton;
  bool isNumeric;
  String? assetUrl;
  bool isTappable;
  dynamic textFieldContent;

  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final viewModel = context.watch<HomeListViewModel>();
    final provider = context.watch<CurrentHomeProvider>();
    return ListTile(
      onTap: !isTappable
          ? null
          : () {
              AppWidget.getModalSheet(
                context: context,
                modalSheetContent: EditModalSheet(
                  sheetTitle: sheetTitle,
                  onUpdated: () async {
                    if (!viewModel.editFormKey.currentState!.validate()) return;
                    Navigator.pop(context);

                    await viewModel.updateField(
                      fieldName: getFirebaseFieldName(title: sheetTitle),
                      newValue: castToDbFieldValue(
                        value: viewModel.displayTextController.text,
                        isDouble: isDouble,
                        isInt: isInt,
                      ),
                    );
                    if (viewModel.status == Status.error) return;
                    if (viewModel.status == Status.completed) {
                      viewModel.getUserHomes();
                      viewModel.displayTextController.clear();
                    } else {
                      AppWidget.showSnackBarWithMsg(
                          msg: 'আপডেট করা সম্ভব হয়নি');
                    }
                  },
                  isNumeric: isNumeric,
                  isDouble: isDouble,
                  isInt: isInt,
                  validationFunciton: validationFunciton,
                  controller: viewModel.displayTextController,
                  formKey: viewModel.editFormKey,
                ),
              );
            },
      leading:
          Icon(leadingIcon, color: isDark ? colorInDarkMode : colorInLightMode),
      title: Text(sheetTitle),
      subtitle: Text(
        subTitle.toString(),
        style: TextStyle(
          color: isDark ? colorInDarkMode : colorInLightMode,
        ),
      ),
    );
  }
}
