import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/renter_opening_page_view_model.dart';

class TransactionDatePicker extends StatelessWidget {
  const TransactionDatePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RenterOpeningViewModel>();
    return OutlinedButton(
      onPressed: () async {
        DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: viewModel.transactionTime,
            firstDate: DateTime(2000),
            lastDate: DateTime(3000));
        if (selectedDate == null) return;

        viewModel.setTransactionTime(selectedDate);
      },
      // child: Text(provider.entryDate.toIso8601String()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 8),
          Text(
            Formatter().buttonFormat(viewModel.transactionTime),
          ),
        ],
      ),
    );
  }
}
