// import 'package:flutter/material.dart';

// class StepperTextField extends StatelessWidget {
//   StepperTextField(
//       {this.label = '',
//       this.isAstrics = false,
//       this.isPhoneNumber = false,
//       this.validationFunciton,
//       required this.textEditingController,
//       super.key});

//   String? Function(String?)? validationFunciton;

//   String label;
//   bool isAstrics, isPhoneNumber;
//   final double _cursorHeight = 22;
//   TextEditingController textEditingController;
//   @override
//   Widget build(BuildContext context) {
//     TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
//           color: Colors.black.withOpacity(0.8),
//         );
//     return isAstrics
//         ? TextFormField(
//             controller: textEditingController,
//             validator: validationFunciton,
//             cursorHeight: _cursorHeight,
//             keyboardType:
//                 isPhoneNumber ? TextInputType.number : TextInputType.name,
//             decoration: InputDecoration(
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               label: getLabelWithAstrics(
//                 label: label,
//                 textStyle: formTextStyle,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           )
//         : TextFormField(
//             controller: textEditingController,
//             validator: validationFunciton,
//             cursorHeight: _cursorHeight,
//             keyboardType:
//                 isPhoneNumber ? TextInputType.number : TextInputType.name,
//             decoration: InputDecoration(
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               label: Text(
//                 label,
//                 style: formTextStyle,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           );
//   }

//   RichText getLabelWithAstrics(
//       {required String label, required TextStyle textStyle}) {
//     return RichText(
//       text: TextSpan(
//         style: textStyle,
//         children: [
//           TextSpan(text: label),
//           TextSpan(
//             text: ' *',
//             style: TextStyle(
//               color: Colors.red[900],
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
