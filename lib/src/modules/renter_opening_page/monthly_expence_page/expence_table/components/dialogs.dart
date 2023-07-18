import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sweet_home/src/constants/constants.dart';

var dialogBorder =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
Future<dynamic> noPrevReadingAlert(BuildContext context, String msg) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Colors.red,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(msg),
        ],
      ),
    ),
  );
}

Future<void> showMonthlyCostConfirmDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: dialogBorder,
        icon: Lottie.asset(AssetPath.doneLottie,
            width: 120, height: 120, repeat: false),
        content: const Text('হিসাবটি তালিকাভুক্ত করা হয়েছে'),

        // actions: [
        //   TextButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       child: const Text(
        //         'ঠিক আছে',
        //         style: TextStyle(fontSize: 18),
        //       )),
        // ],
      );
    },
  );
}

Future<void> notReadyDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: dialogBorder,
        icon: const Text(
          'দুঃক্ষিত !',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        title: const Text(
          'তালিকাভূক্ত করার জন্য হিসাবটি এখনও প্রস্তুত হয়নি',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'মিটারের রিডিং যাচাই করে আবার চেষ্টা করুন',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'ঠিক আছে',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ],
      );
    },
  );
}


//decided not to use dialog for now 
// Future<void> showConfirmDialog(BuildContext context) async {
//   showDialog(
//     context: context,
//     builder: ((context) => AlertDialog(
//           shape: dialogBorder,
//           title: const Text('আপনি কি নিশ্চিত?'),
//           content: const Text('হিসাবটি পরিবর্তনযোগ্য নয়'),
//           actionsAlignment: MainAxisAlignment.end,
//           actions: [
//             TextButton(
//               onPressed: () {},
//               child: const Text(
//                 'পরে',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: const Text(
//                 'নিশ্চিত',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ],
//         )),
//   );
// }
