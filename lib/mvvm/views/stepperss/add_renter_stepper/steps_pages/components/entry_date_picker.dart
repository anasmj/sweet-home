import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view_models/add_renter_view_model.dart';
import '../../../../../utils/formatter.dart';

class EntryDatePicker extends StatelessWidget {
  const EntryDatePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddRenterViewModel>(context, listen: false);

    return OutlinedButton(
      onPressed: () async {
        DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: provider.entryDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(3000));
        if (selectedDate == null) return;
        provider.setEntryDate(selectedDate);
      },
      // child: Text(provider.entryDate.toIso8601String()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 8),
          Text(Formatter()
              .appDateTime(context.watch<AddRenterViewModel>().entryDate)),
        ],
      ),
    );
  }
}
