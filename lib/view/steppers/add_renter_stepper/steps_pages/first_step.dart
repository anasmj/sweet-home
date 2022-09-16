import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/providers/home_provider.dart';
import 'package:sweet_home/providers/newrenter_step_provider.dart';
import 'package:sweet_home/view/steppers/add_renter_stepper/steps_pages/components/occupation_dropdown.dart';
import '../../../../utils/form_validators.dart';
import '../../shared_components/stepper_textfield.dart';

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
    final provider = Provider.of<NewRenterStepProvider>(context);
    String flatName = context.watch<CurrentFlatInfoProvider>().selectedFlat;

    nameController.text = provider.getRenterName;
    provider.firstPageFormKey = firstPageFormKey;

    // TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
    //       color: Colors.black.withOpacity(0.8),
    //     );
    var occupationDropdown = const OccupationDropdown();

    return Form(
      //key needs to exposed to its parent which is NewRenterStepper
      key: provider.firstPageFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          flatNameChip(context, flatName),
          const SizedBox(
            height: 20,
          ),
          StepperTextField(
            label: "গ্রাহকের নাম",
            isAstrics: true,
            textEditingController: nameController,

            validationFunciton: FormValidators
                .checkHomeName, //cant pass the textfield without name
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
                  textEditingController: phoneController,
                  validationFunciton: FormValidators.checkPhoneNumber,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: StepperTextField(
                  isNumeric: true,
                  label: "বিকল্প ফোন নম্বর",
                  textEditingController: alternatePhoneController,
                  validationFunciton: FormValidators.checkPhoneNumber,
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
                children: [
                  const Text(
                    'পেশাঃ ',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  occupationDropdown,
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
                      context.read<NewRenterStepProvider>().incrementMember();
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                  Text(
                    provider.memberNo.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IconButton(
                    iconSize: 22,
                    onPressed: () {
                      context.read<NewRenterStepProvider>().decrementMember();
                    },
                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Text(
          //     'ফ্ল্যাট বাছাই করুনঃ',
          //     style: Theme.of(context).textTheme.subtitle1,
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          //FlatChoicieChips(),
        ],
      ),
    );
  }

  Chip flatNameChip(BuildContext context, String flatName) {
    return Chip(
      label: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'ফ্ল্যাট ',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          TextSpan(
            text: flatName,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ]),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}
