// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rent_home/providers/third_step_provider.dart';

// class AdvancePaymentCheckbox extends StatefulWidget {
//   const AdvancePaymentCheckbox({super.key});

//   @override
//   State<AdvancePaymentCheckbox> createState() => _AdvanceCheckboxState();
// }

// class _AdvanceCheckboxState extends State<AdvancePaymentCheckbox> {
//   bool isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<ThirdStepProvider>();
//     return Checkbox(
//       // value: isChecked,
//       value: provider.advanceStatus,
//       onChanged: (value) => provider.setStatus(value!),
//       // setState(
//       //   () {
//       //     isChecked = !isChecked;
//       //   },
//       // ),
//     );
//   }
// }
