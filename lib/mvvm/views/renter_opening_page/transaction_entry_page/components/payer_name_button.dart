import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/transaction_provider.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/transaction_entry_page/components/payer_name_taker.dart';
import 'package:sweet_home/prev/view/screens/renter_opening_page/transaction_entry_page/components/payer_name_taker.dart';

import '../../../../../../mvvm/models/flat_model.dart';

class PayerNameButton extends StatelessWidget {
  const PayerNameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Flat? currentFlat =
        Provider.of<SelectedFlatVuewModel>(context).selectedFlat;
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
