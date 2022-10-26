// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/mvvm/providers/theme_provider.dart';
// import 'package:sweet_home/mvvm/views/shared_widgets/edit_textfield.dart';
// import 'package:sweet_home/mvvm/views/shared_widgets/update_button.dart';

// class EditFlatInfoSheetContent extends StatelessWidget {
//   const EditFlatInfoSheetContent({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.70,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 20.0, bottom: 30),
//             child: Container(
//               decoration: ShapeDecoration(
//                 shape: const StadiumBorder(),
//                 color: isDarkMode ? Colors.white60 : Colors.grey.shade700,
//               ),
//               height: 4,
//               width: 20,
//             ),
//           ),
//           const Text(
//             'hello',
//             // title,
//             style: TextStyle(fontSize: 24),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Form(
//               // key: context.read<CurrentHomeProvider>().editFormKey,
//               child: EditTextField(
//                   // validationFunciton: validationFunciton,
//                   // isNumeric: willNumeric ?? false,
//                   ),
//             ),
//           ),
//           const SizedBox(
//             height: 50,
//           ),
//           UpdateButton(
//             buttonTitle: '?',
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
