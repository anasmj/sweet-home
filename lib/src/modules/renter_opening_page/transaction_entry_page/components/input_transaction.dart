import 'package:flutter/material.dart';
import 'payer_name_button.dart';
import 'payment_textfield.dart';
import 'transaction_date_picker.dart';

class InputTransaction extends StatelessWidget {
  const InputTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PaymentTextField(),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TransactionDatePicker(transactionPageContext: context),
        ),
        const SizedBox(height: 20),
        PayerNameButton(transactionPageContext: context),
        Text(
          'এর মাধ্যমে',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
