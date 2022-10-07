import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/transaction_provider.dart';
import 'package:sweet_home/mvvm/utils/custom_date_time_formatter.dart';

class TransactionDatePicker extends StatelessWidget {
  const TransactionDatePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TransactionProvider>();
    String buttonDate =
        CustomFormatter().buttonFormat(provider.transactionDateTime);

    return OutlinedButton(
      onPressed: () async {
        DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000));
        if (selectedDate == null) return;
        provider.transactionDateTime = selectedDate;
      },
      // child: Text(provider.entryDate.toIso8601String()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 8),
          Text(buttonDate),
        ],
      ),
    );
  }
}
