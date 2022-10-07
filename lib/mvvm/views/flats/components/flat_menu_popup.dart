// import 'package:flutter/material.dart';
//! function shifteed into onLongPress, kept if descision changes 
// class FlatMenuPopup extends StatelessWidget {
//   const FlatMenuPopup({super.key});

//   static const String editOption = "তথ্য পরিবর্তন";
//   static const String deleteOption = "গ্রাহক মুছুন";
//   static const String flatDetailOption = "ফ্ল্যাটের বিস্তারিত";

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(
//       tooltip: 'মেন্যু',
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       itemBuilder: (BuildContext context) => [
//         const PopupMenuItem(
//           value: editOption,
//           child: Text(editOption),
//         ),
//         const PopupMenuItem(
//           value: deleteOption,
//           child: Text(deleteOption),
//         ),
//         const PopupMenuItem(
//           value: flatDetailOption, //value can be int or any type
//           child: Text(flatDetailOption),
//         ),
//       ],
//       onSelected: (value) {
//         switch (value) {
//           case 'তথ্য পরিবর্তন':
//             break; //_showModalSheet(),
//           case 'গ্রাহক মুছুন':
//             break; //_showModalSheet(),

//           case 'ফ্ল্যাটের বিস্তারিত':
//             break; //_showModalSheet(),
//         }
//       },
//     );
//   }
// }
