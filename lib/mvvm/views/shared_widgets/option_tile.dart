import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/home_crud_helper.dart';
import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';
import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/edit_modal_sheet.dart';

// ignore: must_be_immutable
class OptionTile extends StatelessWidget {
  OptionTile({
    super.key,
    // required this.home,
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
    this.flatListViewModel,
    this.homeListViewModel,
  });
  // Home home;
  IconData? leadingIcon;
  String sheetTitle, subTitle;
  bool isDouble, isInt;
  String? Function(String?)? validationFunciton;
  bool isNumeric;
  String? assetUrl;
  bool isTappable;
  dynamic textFieldContent;

  FlatListViewModel? flatListViewModel;
  HomeListViewModel? homeListViewModel;

  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    // final viewModel = context.watch<HomeListViewModel>();
    if (homeListViewModel != null) {
      return ListTile(
        onTap: !isTappable
            ? null
            : () {
                AppWidget.getModalSheet(
                  context: context,
                  modalSheetContent: EditModalSheet(
                    sheetTitle: sheetTitle,
                    onUpdated: () async {
                      if (!homeListViewModel!.editFormKey.currentState!
                          .validate()) {
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
                        AppWidget.showSnackBarWithMsg(
                            msg: 'আপডেট করা সম্ভব হয়নি');
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
    if (flatListViewModel != null) {
      return ListTile(
        onTap: !isTappable
            ? null
            : () {
                AppWidget.getModalSheet(
                  context: context,
                  modalSheetContent: EditModalSheet(
                    sheetTitle: sheetTitle,
                    onUpdated: () async {
                      if (!flatListViewModel!.editFlatFormKey.currentState!
                          .validate()) {
                        return;
                      }
                      Navigator.pop(context);
                      await flatListViewModel!.updateField(
                        fieldName: getFirebaseFieldName(title: sheetTitle),
                        newValue: castToDbFieldValue(
                          value: flatListViewModel!.displayTextController.text,
                          isDouble: isDouble,
                          isInt: isInt,
                        ),
                        flatName: Provider.of<SelectedFlatProvider>(context,
                                listen: false)
                            .selectedFlat!
                            .flatName,
                      );

                      if (flatListViewModel!.status == Status.error) return;
                      if (flatListViewModel!.status == Status.completed) {
                        await flatListViewModel!.configureFltas();
                        flatListViewModel!.displayTextController.clear();
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
                    controller: flatListViewModel!.displayTextController,
                    formKey: flatListViewModel!.editFlatFormKey,
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
    return const Scaffold();
  }
}




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/mvvm/models/theme_provider.dart';
// import 'package:sweet_home/mvvm/utils/home_crud_helper.dart';
// import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';
// import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
// import 'package:sweet_home/mvvm/views/app_widgets.dart';
// import 'package:sweet_home/mvvm/views/shared_widgets/edit_modal_sheet.dart';

// // ignore: must_be_immutable
// class OptionTile extends StatelessWidget {
//   OptionTile({
//     super.key,
//     // required this.home,
//     this.leadingIcon,
//     required this.sheetTitle,
//     required this.subTitle,
//     this.isDouble = false,
//     this.isInt = false,
//     this.validationFunciton,
//     this.isNumeric = true,
//     this.isTappable = true,
//     this.assetUrl,
//     this.textFieldContent,
//     this.flatListViewModel,
//     this.homeListViewModel,
//     // this.onClick,
//   });
//   // Home home;
//   IconData? leadingIcon;
//   String sheetTitle, subTitle;
//   bool isDouble, isInt;
//   String? Function(String?)? validationFunciton;
//   bool isNumeric;
//   String? assetUrl;
//   bool isTappable;
//   dynamic textFieldContent;

//   FlatListViewModel? flatListViewModel;
//   HomeListViewModel? homeListViewModel;
//   // VoidCallback? onClick;

//   final Color colorInLightMode = Colors.grey.shade700;
//   final Color modalSheetBgDark = Colors.grey.shade900;
//   final Color modalSheetBgLight = Colors.white;
//   final Color colorInDarkMode = Colors.white;
//   @override
//   Widget build(BuildContext context) {
//     bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
//     final viewModel = context.watch<HomeListViewModel>();
//     if (homeListViewModel != null) print('got home');
//     if (flatListViewModel != null) print('got home');

//     return ListTile(
//       onTap: !isTappable
//           ? null
//           : () {
//               AppWidget.getModalSheet(
//                 context: context,
//                 modalSheetContent: EditModalSheet(
//                   sheetTitle: sheetTitle,
//                   onUpdated: () async {
//                     if (!viewModel.editFormKey.currentState!.validate()) return;
//                     Navigator.pop(context);

//                     await viewModel.updateField(
//                       fieldName: getFirebaseFieldName(title: sheetTitle),
//                       newValue: castToDbFieldValue(
//                         value: viewModel.displayTextController.text,
//                         isDouble: isDouble,
//                         isInt: isInt,
//                       ),
//                     );
//                     if (viewModel.status == Status.error) return;
//                     if (viewModel.status == Status.completed) {
//                       viewModel.getUserHomes();
//                       viewModel.displayTextController.clear();
//                     } else {
//                       AppWidget.showSnackBarWithMsg(
//                           msg: 'আপডেট করা সম্ভব হয়নি');
//                     }
//                   },
//                   isNumeric: isNumeric,
//                   isDouble: isDouble,
//                   isInt: isInt,
//                   validationFunciton: validationFunciton,
//                   controller: viewModel.displayTextController,
//                   formKey: viewModel.editFormKey,
//                 ),
//               );
//             },
//       leading:
//           Icon(leadingIcon, color: isDark ? colorInDarkMode : colorInLightMode),
//       title: Text(sheetTitle),
//       subtitle: Text(
//         subTitle.toString(),
//         style: TextStyle(
//           color: isDark ? colorInDarkMode : colorInLightMode,
//         ),
//       ),
//     );
//   }
// }
