import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/transaction_provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_view_model.dart';
import 'package:sweet_home/mvvm/repositories/transaction_service.dart';
import 'package:sweet_home/mvvm/utils/custom_date_time_formatter.dart';

class TransactionSubmitButton extends StatelessWidget {
  String text;
  TransactionSubmitButton({required this.text, super.key});
  final recordId = CustomFormatter().makeId(date: DateTime.now());
  @override
  Widget build(BuildContext context) {
    final provider = context.read<TransactionProvider>();

    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      minWidth: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      color: Theme.of(context).secondaryHeaderColor,
      disabledColor: Colors.grey,
      onPressed: () async {
        if (provider.paymentKey.currentState!.validate()) {
          Response res = await TransactionService().addTransaction(
            paidBy: provider.payerName,
            amount: double.parse(provider.paymentController.text),
            dateTime: provider.transactionDateTime,
            homeId: context.read<CurrentHomeProvider>().currentHome!.homeId,
            flatId:
                context.read<SelectedFlatVuewModel>().selectedFlat!.flatName,
            recordId: recordId,
          );
          if (res.code == 200) {
            // ignore: use_build_context_synchronously
            provider.payerController.clear();
            provider.paymentController.clear();
            provider.transactionDateTime = DateTime.now();

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('লেনদেনটি যুক্ত করা হয়েছে')));
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('কোনও একটি সমস্যা হয়েছে, একটু পর আবার চেষ্টা করুন ')));
          }
        }
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
