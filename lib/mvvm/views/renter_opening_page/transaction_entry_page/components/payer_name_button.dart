import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/transaction_provider.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/transaction_entry_page/components/payer_name_taker.dart';

class PayerNameButton extends StatelessWidget {
  const PayerNameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<TransactionProvider>().payerController.text =
    //     currentFlat!.renter!.renterName;
    return TextButton(
      onPressed: () async {
        showNamePicker(context: context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.read<TransactionProvider>().payerName,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.edit,
            size: 12,
          )
        ],
      ),
    );
  }
}
