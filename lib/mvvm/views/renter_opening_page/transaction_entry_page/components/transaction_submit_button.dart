import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/transaction_provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/transaction_service.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/renter_opening_page_view_model.dart';

// ignore: must_be_immutable
class TransactionSubmitButton extends StatelessWidget {
  TransactionSubmitButton({super.key, required this.transactionPageContext});
  final recordId = Formatter().makeId(date: DateTime.now());
  BuildContext transactionPageContext;
  final String buttonText = 'বুঝে পেলাম';
  @override
  Widget build(BuildContext context) {
    // final provider = context.read<TransactionProvider>();
    final viewModel = context.read<RenterOpeningViewModel>();

    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      minWidth: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      color: Theme.of(context).secondaryHeaderColor,
      disabledColor: Colors.grey,
      onPressed: () async {
        FocusScope.of(transactionPageContext).unfocus();

        viewModel.paymentKey.currentState!.validate();
        print(viewModel.payerName);
        print(viewModel.paymentController.text);
        print(viewModel.transactionTime);
        // if (provider.paymentKey.currentState!.validate()) {
        //   Response res = await TransactionService().addTransaction(
        //     paidBy: provider.payerName,
        //     amount: double.parse(provider.paymentController.text),
        //     dateTime: provider.transactionDateTime,
        //     homeId: context.read<CurrentHomeProvider>().currentHome!.homeId,
        //     flatId: context.read<SelectedFlatProvider>().selectedFlat!.flatName,
        //     recordId: recordId,
        //   );
        //   if (res.code == 200) {
        //     // ignore: use_build_context_synchronously
        //     provider.payerController.clear();
        //     provider.paymentController.clear();
        //     provider.transactionDateTime = DateTime.now();

        //     // ignore: use_build_context_synchronously
        //     ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text('লেনদেনটি যুক্ত করা হয়েছে')));
        //   } else {
        //     // ignore: use_build_context_synchronously
        //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //         content:
        //             Text('কোনও একটি সমস্যা হয়েছে, একটু পর আবার চেষ্টা করুন ')));
        //   }
        // }
      },
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
