import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/view_models/renter_opening_page_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/transaction_entry_page/components/payer_name_taker.dart';

// ignore: must_be_immutable
class PayerNameButton extends StatelessWidget {
  PayerNameButton({
    Key? key,
    required this.transactionPageContext,
  }) : super(key: key);
  BuildContext transactionPageContext;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RenterOpeningViewModel>(context);
    return TextButton(
      onPressed: () async {
        FocusScope.of(transactionPageContext).unfocus();
        showNamePicker(context: context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            viewModel.payerName,
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
