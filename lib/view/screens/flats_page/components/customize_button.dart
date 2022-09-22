// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/providers/theme_provider.dart';

// import 'package:sweet_home/view/resources/app_icons.dart';

// //THIS BUTTON LETS USER CUSTOMIZE THEIR FLAT INFORMTAION INDIVIDUALLY
// class CustomizeButton extends StatelessWidget {
//   const CustomizeButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextTheme appTextTheme = Theme.of(context).textTheme;

//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor:
//             MaterialStateProperty.all(Theme.of(context).primaryColor),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//       ),
//       onPressed: null,
//       child: Row(
//         children: [
//           Text(
//             'তথ্য নির্ধারণ',
//             style: appTextTheme.subtitle1,
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           SvgPicture.asset(
//             AppIcons.settingUrl,
//             color: context.watch<ThemeProvider>().isDarkMode
//                 ? Colors.white
//                 : Colors.black,
//             height: 20,
//           )
//         ],
//       ),
//     );
//   }
// }
