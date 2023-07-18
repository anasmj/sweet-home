import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sweet_home/src/constants/constants.dart';

import 'components/input_transaction.dart';
import 'components/transaction_submit_button.dart';

class TransactionEntryPage extends StatelessWidget {
  const TransactionEntryPage({super.key});

  // final double _buttonSpaceFromBottom = 220;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: InputTransaction(),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0),
          child: CircularProgressIndicator(),
        ),

        Visibility(
            visible: false,
            child: TransactionSubmitButton(transactionPageContext: context)),
        // viewModel.status == Status.completed
        //     ? const SizedBox.shrink()
        //     : TransactionSubmitButton(transactionPageContext: context),
      ],
    );
  }

  Column successWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          AssetPath.successWallet,
          height: 120,
          repeat: false,
        ),
        Text('লেনদেনটি যুক্ত করা হয়েছে',
            style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
