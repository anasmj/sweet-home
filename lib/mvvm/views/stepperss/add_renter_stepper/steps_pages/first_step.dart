import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';

import '../../../../models/flat_model.dart';
import '../../../../providers/selected_flat_provider.dart';
import '../../../../view_models/add_renter_view_model.dart';
import '../../../../utils/form_validators.dart';
import '../../components/stepper_textfield.dart';
import 'components/occupation_dropdown.dart';

// ignore: must_be_immutable
class RenterInfoStep extends StatelessWidget {
  RenterInfoStep({
    Key? key,
  }) : super(key: key);
  int numOfMember = 2;

  final firstPageFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final alternatePhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddRenterViewModel>(context);
    Flat? flat = context.watch<SelectedFlatProvider>().selectedFlat;

    // nameController.text = provider.getRenterName;
    provider.firstPageFormKey = firstPageFormKey;

    clearProviderInfo() {
      provider.renterNameController.clear();
      provider.phoneController.clear();
      provider.altPhoneController.clear();
      provider.advanceController.clear();
      provider.setOccupation();
      provider.setMemberNo = 2;
      provider.advanceController.clear();
    }

    return WillPopScope(
      onWillPop: () async {
        clearProviderInfo();

        return true;
      },
      child: Form(
        //key needs to exposed to its parent which is NewRenterStepper
        key: provider.firstPageFormKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            flatNameChip(context, flat!.flatName),
            const SizedBox(
              height: 20,
            ),
            StepperTextField(
              label: "গ্রাহকের নাম",
              isAstrics: true,
              textEditingController: provider.renterNameController,
              // textEditingController: nameController,

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
                    textEditingController: provider.phoneController,
                    // textEditingController: phoneController,
                    // validationFunciton: FormValidators.checkPhoneNumber,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: StepperTextField(
                    isNumeric: true,
                    label: "বিকল্প ফোন নম্বর",
                    textEditingController: provider.altPhoneController,
                    // validationFunciton: FormValidators.checkPhoneNumber,
                    // textEditingController: alternatePhoneController,
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
                //occupation drop down
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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

                //number of member counter
                const Text(
                  'সদস্য সংখ্যা',
                  style: TextStyle(fontSize: 16),
                ),
                //increment or decrement
                Column(
                  children: [
                    IconButton(
                      iconSize: 22,
                      onPressed: () {
                        context.read<AddRenterViewModel>().incrementMember();
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                    Text(
                      Formatter.toBn(
                          value: provider.memberNo, includeSymbol: false),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      iconSize: 22,
                      onPressed: () {
                        context.read<AddRenterViewModel>().decrementMember();
                      },
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
              textEditingController: provider.nIdController,
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
