import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/add_renter_stepper/provider/new.renter.provider.dart';
import 'package:sweet_home/src/utils/formatter.dart';

class EntryDatePicker extends ConsumerWidget {
  const EntryDatePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final newRenter = ref.watch(newRenterProvider);
    return OutlinedButton(
      onPressed: () async {
        DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: newRenter.entryDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000));
        if (selectedDate == null) return;
        ref.read(newRenterProvider.notifier).setEntryDate(selectedDate);
      },
      // child: Text(provider.entryDate.toIso8601String()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 8),
          Text(
            Formatter().appDateTime(
              newRenter.entryDate ?? DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }
}
