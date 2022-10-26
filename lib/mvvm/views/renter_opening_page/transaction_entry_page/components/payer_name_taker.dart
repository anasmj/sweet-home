import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/view_models/renter_opening_page_view_model.dart';

Future<void> showNamePicker(
    {required BuildContext context, String title = ''}) async {
  // final payerController = context.read<TransactionProvider>().payerController;
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey();
  // final transactionProvider = Provider.of<TransactionProvider>(context);

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('প্রদানকারীর নাম'),
        content: Form(
          key: key,
          // key: context.read<TransactionProvider>().payerKey,
          child: TextFormField(
            controller: controller,
            // controller: payerController,

            validator: (value) {
              if (value!.isEmpty) {
                return 'প্রদানকারীর নাম দেয়া হয়নি';
              }
              return null;
            },
            decoration: const InputDecoration(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'বাতিল',
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            child: const Text(
              'ঠিক আছে',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              if (key.currentState!.validate()) {
                Provider.of<RenterOpeningViewModel>(context, listen: false)
                    .setPayerName(controller.text);

                // print(payerController.text);
                // payerController.clear();
                // context.read<TransactionProvider>().setPayer(tempName);
                Navigator.of(context).pop();
              }
              // if (context
              //     .read<TransactionProvider>()
              //     .payerKey
              //     .currentState!
              //     .validate()) {
              //   Provider.of<TransactionProvider>(context, listen: false)
              //       .setPayerName(transactionProvider.paymentController.text);

              //   print(payerController.text);
              //   // payerController.clear();
              //   // context.read<TransactionProvider>().setPayer(tempName);
              //   Navigator.of(context).pop();
              // }
            },
          ),
        ],
      );
    },
  );
}
