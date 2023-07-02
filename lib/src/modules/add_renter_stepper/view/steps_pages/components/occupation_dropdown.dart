import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/add_renter_stepper/provider/new.renter.provider.dart';

class OccupationDropdown extends ConsumerWidget {
  const OccupationDropdown({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final occupations = ref.watch(newRenterProvider.notifier).occupationOptions;
    final occupation = ref.watch(newRenterProvider.select((v) => v.occupation));

    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      value: occupation,
      elevation: 10,
      onChanged: ref.read(newRenterProvider.notifier).setOccupation,
      items: occupations
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                // style: formTextStyle,
              ),
            ),
          )
          .toList(),
    );
  }
}
