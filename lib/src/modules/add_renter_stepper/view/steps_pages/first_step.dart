import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/stepper.textfield/stepper_textfield.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/modules/flats/provider/selected.flat.provider.dart';
import 'package:sweet_home/src/providers/form.key.provider.dart';
import 'package:sweet_home/src/utils/form_validators.dart';
import 'package:sweet_home/src/utils/formatter.dart';
import 'package:sweet_home/src/utils/validators.dart';

import '../../provider/current.setep.provider.dart';
import '../../provider/new.renter.provider.dart';
import 'components/occupation_dropdown.dart';

class RenterInfoStep extends ConsumerWidget {
  const RenterInfoStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    Flat? flat = ref.watch(selectedFlatProvider);
    return WillPopScope(
      onWillPop: () async {
        ref.invalidate(newRenterProvider);
        ref.invalidate(newRenterStepProvider);
        return true;
      },
      child: Form(
        key: ref.watch(formKeyProvider(FormKey.renterFirstPage)),
        child: Column(
          children: [
            _FlatNameChip(flatName: flat!.flatName),
            const SizedBox(height: 20),
            StepperTextField(
              label: "গ্রাহকের নাম",
              isAstrics: true,
              onChanged: ref.read(newRenterProvider.notifier).onNameChanged,
              validation: FormValidators.checkEmpty,
            ),
            height20,
            const _PhoneRow(),
            height10,
            const _OccupationAndMember(),
            height20,
          ],
        ),
      ),
    );
  }
}

class _OccupationAndMember extends ConsumerWidget {
  const _OccupationAndMember();

  @override
  Widget build(BuildContext context, ref) {
    final newRenterNotifier = ref.watch(newRenterProvider.notifier);
    final numOfPerson =
        ref.watch(newRenterProvider.select((renter) => renter.numOfPerson));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'পেশাঃ ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 20,
            ),
            OccupationDropdown(),
          ],
        ),
        const Spacer(),
        const Text(
          'সদস্য সংখ্যা',
          style: TextStyle(fontSize: 16),
        ),
        Column(
          children: [
            IconButton(
              iconSize: 22,
              onPressed: newRenterNotifier.increaseMember,
              icon: const Icon(Icons.add),
            ),
            Text(
              Formatter.toBn(value: numOfPerson, includeSymbol: false),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IconButton(
              iconSize: 22,
              onPressed: newRenterNotifier.decreaseMember,
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      ],
    );
  }
}

class _PhoneRow extends ConsumerWidget {
  const _PhoneRow();

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.watch(newRenterProvider.notifier);
    return Row(
      children: [
        Expanded(
          child: StepperTextField(
            isNumeric: true,
            label: 'ফোন নম্বর',
            isAstrics: true,
            onChanged: notifier.onPhoneChanged,
            validation: Validator.phone,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: StepperTextField(
            isNumeric: true,
            label: "বিকল্প ফোন নম্বর",
            onChanged: notifier.onPhone2Changed,
          ),
        ),
      ],
    );
  }
}

class _FlatNameChip extends StatelessWidget {
  const _FlatNameChip({required this.flatName});
  final String flatName;
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'ফ্ল্যাট ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TextSpan(
            text: flatName,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ]),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}
