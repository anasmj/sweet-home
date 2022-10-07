// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../../providers/transaction_provider.dart';

// Future<void> showNamePicker(
//     {required BuildContext context, String title = ''}) async {
//   late String tempName = '';
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         title: const Text('প্রদানকারীর নাম'),
//         content: Form(
//           key: context.read<TransactionProvider>().payerKey,
//           child: TextFormField(
//             controller: context.read<TransactionProvider>().payerController,
//             onChanged: (value) {
//               tempName = value;
//             },
//             // controller: context.read<TransactionProvider>().payerController,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'প্রদানকারীর নামটি দেয়া হয়নি';
//               }
//               return null;
//             },
//             decoration: const InputDecoration(),
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text(
//               'বাতিল',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           TextButton(
//             child: const Text(
//               'ঠিক আছে',
//               style: TextStyle(fontSize: 16),
//             ),
//             onPressed: () {
//               if (context
//                   .read<TransactionProvider>()
//                   .payerKey
//                   .currentState!
//                   .validate()) {
//                 context.read<TransactionProvider>().setPayer(tempName);
//                 Navigator.of(context).pop();
//               }
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
