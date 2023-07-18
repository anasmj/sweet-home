import 'package:flutter/material.dart';
import 'package:sweet_home/src/extensions/extensions.dart';

// ignore: must_be_immutable
class TransactionDatePicker extends StatelessWidget {
  TransactionDatePicker({Key? key, required this.transactionPageContext})
      : super(key: key);
  BuildContext transactionPageContext;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        FocusScope.of(transactionPageContext).unfocus();
        DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000));
        if (selectedDate == null) return;
      },
      // child: Text(provider.entryDate.toIso8601String()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 8),
          Text(
            DateTime.now().formatted(),
          ),
        ],
      ),
    );
  }
}
