import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/view_models/renter_view_model.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';
import 'components/input_transaction.dart';
import 'components/transaction_submit_button.dart';

class TransactionEntryPage extends StatelessWidget {
  const TransactionEntryPage({super.key});

  // final double _buttonSpaceFromBottom = 220;
  adasd() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RenterViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: InputTransaction(),
        ),
        viewModel.status == Status.completed
            ? Lottie.asset(
                AppIcons.success_wallet,
                height: 120,
                repeat: false,
              )
            : const SizedBox.shrink(),
        viewModel.isLoading
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: CircularProgressIndicator(),
              )
            : const SizedBox.shrink(),
        TransactionSubmitButton(transactionPageContext: context),
      ],
    );
  }
}
