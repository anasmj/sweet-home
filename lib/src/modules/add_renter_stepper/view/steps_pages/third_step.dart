import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/stepper.textfield/stepper_textfield.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/extensions/extensions.dart';
import 'package:sweet_home/src/modules/add_renter_stepper/provider/new.renter.provider.dart';

import 'components/entry_date_picker.dart';

class ThirdStepPage extends ConsumerWidget {
  const ThirdStepPage({super.key});
  @override
  Widget build(BuildContext context, ref) {
    ref.watch(newRenterProvider);
    final includeAdvance = ref.watch(newRenterProvider.notifier).includeAdvance;

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: includeAdvance,
              onChanged: ref.watch(newRenterProvider.notifier).setAdvance,
            ),
            const Text('অগ্রীম'),
            const SizedBox(width: 20),
            const AdvanceTextField(),
          ],
        ),
        if (includeAdvance) const PaidBy(),
        height20,
        const EntryDatePicker(),
        height30,
      ],
    );
  }
}

class PaidBy extends ConsumerWidget {
  const PaidBy({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        SizedBox(
          width: 180,
          child: StepperTextField(
            initialValue: ref.watch(newRenterProvider).renterName,
          ),
        ),
        Text(
          'এর মাধ্যমে',
          style: context.text.titleLarge,
        ),
      ],
    );
  }
}

class AdvanceTextField extends ConsumerWidget {
  const AdvanceTextField({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(newRenterProvider);
    final includeAdvance = ref.watch(newRenterProvider.notifier).includeAdvance;
    return SizedBox(
      width: 120,
      height: 40,
      child: TextFormField(
        onChanged: ref.watch(newRenterProvider.notifier).onAdvanceChanged,
        enabled: includeAdvance,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.w500),
        keyboardType: TextInputType.number,
        cursorHeight: 22,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 18,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4),
            child: Image(
              color: Colors.black.withOpacity(0.80),
              image: AssetImage(
                AssetPath.takaUrl,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
