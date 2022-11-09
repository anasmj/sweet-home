import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/renter_view_model.dart';

// ignore: must_be_immutable
class TransactionSubmitButton extends StatelessWidget {
  TransactionSubmitButton({
    super.key,
    required this.transactionPageContext,
  });

  final recordId = Formatter().makeId(date: DateTime.now());
  BuildContext transactionPageContext;
  final String buttonText = 'বুঝে পেলাম';
  Response response = Response();
  @override
  Widget build(BuildContext context) {
    // final provider = context.read<TransactionProvider>();
    final viewModel = context.read<RenterViewModel>();
    final String? homeId = context
        .watch<CurrentHomeProvider>()
        .currentHome
        ?.homeId; //todo: check this line out

    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      minWidth: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      color: Theme.of(context).secondaryHeaderColor,
      disabledColor: Colors.grey,
      onPressed: () async {
        FocusScope.of(transactionPageContext).unfocus();
        if (homeId == null) return;
        if (viewModel.paymentKey.currentState!.validate()) {
          await viewModel.addTransactionToRenter(homeId: homeId);
        }
      },
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
