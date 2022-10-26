import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/transaction_entry_page/components/payment_textfield.dart';
import 'components/payer_name_button.dart';
import 'components/transaction_date_picker.dart';
import 'components/transaction_submit_button.dart';

class TransactionEntryPage extends StatelessWidget {
  const TransactionEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
          ),
          // const PaymentInputTextField(),
          const PaymentTextField(),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: TransactionDatePicker(),
          ),
          const SizedBox(height: 20),
          PayerNameButton(transactionPageContext: context),
          Text(
            'এর মাধ্যমে',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          // const Spacer(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: TransactionSubmitButton(transactionPageContext: context),
          ),
        ],
      ),
    );
  }
}
