import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/modules/add_renter_stepper/provider/new.renter.provider.dart';
import 'package:sweet_home/src/providers/text.controller.provider.dart';

import 'components/entry_date_picker.dart';

class ThirdStepPage extends ConsumerWidget {
  const ThirdStepPage({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.watch(newRenterProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(value: false, onChanged: notifier.setAdvance),
            const Text('অগ্রীম'),
            const SizedBox(
              width: 20,
            ),
            const AdvanceTextField(),
          ],
        ),
        const SizedBox(height: 20),
        const EntryDatePicker(),
      ],
    );
  }
}

class AdvanceTextField extends ConsumerWidget {
  const AdvanceTextField({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      width: 120,
      height: 40,
      child: TextFormField(
        controller: ref.watch(tecProvider(Field.renterAdvance)),
        // controller: controller,
        // enabled: provider.advanceStatus,
        enabled: false,
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
