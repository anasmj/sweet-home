import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/utils/custom_date_time_formatter.dart';

import '../../../../../providers/newrenter_step_provider.dart';

class EntryDatePicker extends StatelessWidget {
  const EntryDatePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewRenterStepProvider>();
    String date = CustomFormatter().buttonFormat(provider.entryDate);

    return ElevatedButton(
      onPressed: () async {
        DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000));
        if (selectedDate == null) return;
        provider.setEntryDate = selectedDate;
      },
      // child: Text(provider.entryDate.toIso8601String()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 8),
          Text(date),
        ],
      ),
    );
  }
}
