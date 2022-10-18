// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/mvvm/models/home_model.dart';
// import 'package:sweet_home/mvvm/models/theme_provider.dart';
// import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
// import 'package:sweet_home/mvvm/utils/home_crud_helper.dart';
// import 'package:sweet_home/mvvm/views/app_widgets.dart';
// import 'package:sweet_home/mvvm/views/shared_widgets/edit_textfield.dart';
// import 'package:sweet_home/mvvm/views/shared_widgets/update_button.dart';

//! moved into shared widget, will be deleted if no problem arises 
// // ignore: must_be_immutable
// class OnPressSheetContent extends StatelessWidget {
//   OnPressSheetContent({
//     super.key,
//     // required this.home,
//     required this.sheetTitle,
//     this.isNumeric = true,
//     this.isDouble = false,
//     this.isInt = false,
//     this.validationFunciton,
//     this.textFieldContent,
//   });
//   // Home home;
//   String sheetTitle;
//   String? Function(String?)? validationFunciton;
//   bool isNumeric;
//   bool isDouble, isInt;
//   dynamic textFieldContent;

//   @override
//   Widget build(BuildContext context) {
//     // CurrentHomeProvider provider = context.read<CurrentHomeProvider>();
//     HomeListViewModel viewModel = context.read<HomeListViewModel>();
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.75,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 20.0, bottom: 30),
//             child: modalSheetDivider(),
//           ),
//           Text(
//             sheetTitle,
//             style: const TextStyle(fontSize: 24),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Form(
//               key: viewModel.editFormKey,
//               child: EditTextField(
//                 label: sheetTitle,
//                 validationFunciton: validationFunciton,
//                 isNumeric: isNumeric,
//                 editingController: viewModel.displayTextController,
//                 textFieldContent: textFieldContent,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           UpdateButton(
//             buttonTitle: 'আপডেট',
//             onPressed: () async {
//               // String? id =
//               //     context.read<CurrentHomeProvider>().currentHome?.homeId;
//               if (!viewModel.editFormKey.currentState!.validate()) return;
//               // if (id == null) return;
//               // viewModel.setStatus(Status.loading);
//               await viewModel.updateField(
//                 fieldName: getFirebaseFieldName(title: sheetTitle),
//                 newValue: castToDbFieldValue(
//                   value: viewModel.displayTextController.text,
//                   isDouble: isDouble,
//                   isInt: isInt,
//                 ),
//               );

//               if (viewModel.status == Status.completed) {
//                 // ignore: use_build_context_synchronously
//                 Navigator.pop(context);
//                 viewModel.displayTextController.clear();
//                 viewModel.getUserHomes();
//                 // ignore: use_build_context_synchronously
//               } else {
//                 AppWidget.showSnackBarWithMsg(msg: 'আপডেট করা সম্ভব হয়নি');
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   RoundedRectangleBorder modalSheetStyle() {
//     return const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(20),
//         topRight: Radius.circular(20),
//       ),
//     );
//   }

//   Widget modalSheetDivider() {
//     return Builder(builder: (context) {
//       bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
//       return Container(
//         decoration: ShapeDecoration(
//           shape: const StadiumBorder(),
//           color: isDarkMode ? Colors.white60 : Colors.grey.shade700,
//         ),
//         height: 4,
//         width: 20,
//       );
//     });
//   }
// }
