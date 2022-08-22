import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_home/providers/newrenter_step_provider.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/steps_pages/components/occupation_dropdown.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/steps_pages/components/stepper_textfield.dart';
import 'components/flat_choice_chip.dart';

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

    nameController.text = provider.renterName;
    provider.firstPageFormKey = firstPageFormKey;

    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    var occupationDropdown = const OccupationDropdown();

    return Form(
      //key needs to exposed to its parent which is NewRenterStepper
      key: provider.firstPageFormKey,
      child: Column(
        children: [
          StepperTextField(
            label: "গ্রাহকের নাম",
            isAstrics: true,
            textEditingController: nameController,

            // validationFunciton: Validator
            // .checkRenterName, // validation is a class which contains
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: StepperTextField(
                  isPhoneNumber: true,
                  label: 'ফোন নম্বর',
                  isAstrics: true,
                  textEditingController: phoneController,
                  // validationFunciton: Validator.checkPhoneNumber,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: StepperTextField(
                  isPhoneNumber: true,
                  label: "বিকল্প ফোন নম্বর",
                  textEditingController: alternatePhoneController,
                  // validationFunciton: Validator.checkPhoneNumber,
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
                  Text(
                    'পেশাঃ ',
                    style: formTextStyle,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  occupationDropdown,
                ],
              ),
              const Spacer(),

              //number of member counter
              Text(
                'সদস্য সংখ্যা',
                style: formTextStyle,
              ),
              //increment or decrement
              Column(
                children: [
                  IconButton(
                    iconSize: 22,
                    onPressed: () {
                      context.read<NewRenterStepProvider>().incrementMember();
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    provider.memberNo,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IconButton(
                    iconSize: 22,
                    onPressed: () {
                      context.read<NewRenterStepProvider>().decrementMember();
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'ফ্ল্যাট বাছাই করুনঃ',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FlatChoicieChips(),
        ],
      ),
    );
  }
}
