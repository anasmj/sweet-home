import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/stepper.textfield/stepper_textfield.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/modules/flats/provider/selected.flat.provider.dart';
import 'package:sweet_home/src/providers/form.key.provider.dart';
import 'package:sweet_home/src/utils/form_validators.dart';
import 'package:sweet_home/src/utils/formatter.dart';

import '../../../providers/text.controller.provider.dart';
import '../provider/new.renter.provider.dart';
import 'components/occupation_dropdown.dart';

// ignore: must_be_immutable
class RenterInfoStep extends ConsumerWidget {
  RenterInfoStep({
    Key? key,
  }) : super(key: key);
  int numOfMember = 2;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final alternatePhoneController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    Flat? flat = ref.watch(selectedFlatNotifier);
    final newRenterNotifier = ref.watch(newRenterProvider.notifier);
    final newRenter = ref.watch(newRenterProvider);
    // nameController.text = provider.getRenterName;

    return WillPopScope(
      onWillPop: () async {
        ref.invalidate(newRenterProvider);
        return true;
      },
      child: Form(
        key: ref.watch(formKeyProvider(FormKey.renterFirstPage)),
        child: Column(
          children: [
            flatNameChip(context, flat!.flatName),
            const SizedBox(
              height: 20,
            ),
            StepperTextField(
              label: "গ্রাহকের নাম",
              isAstrics: true,
              textEditingController: ref.watch(tecProvider(Field.renterName)),

              validationFunciton: FormValidators
                  .checkEmpty, //cant pass the textfield without name
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: StepperTextField(
                    isNumeric: true,
                    label: 'ফোন নম্বর',
                    isAstrics: true,
                    textEditingController:
                        ref.watch(tecProvider(Field.renterPhone)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: StepperTextField(
                    isNumeric: true,
                    label: "বিকল্প ফোন নম্বর",
                    textEditingController:
                        ref.watch(tecProvider(Field.renterPhone2)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
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
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                    Text(
                      Formatter.toBn(
                          value: newRenter.numOfPerson, includeSymbol: false),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      iconSize: 22,
                      onPressed: newRenterNotifier.decreaseMember,
                      icon: const Icon(
                        Icons.remove,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('ভোটার আইডি কার্ডের নম্বরঃ ')),
            StepperTextField(
              isNumeric: true,
              textEditingController: ref.watch(tecProvider(Field.renterNid)),
            ),

            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Text(
            //     'ফ্ল্যাট বাছাই করুনঃ',
            //     style: Theme.of(context).textTheme.titleMedium,
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            //FlatChoicieChips(),
          ],
        ),
      ),
    );
  }

  Chip flatNameChip(BuildContext context, String flatName) {
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
