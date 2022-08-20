import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_home/providers/new_renter_info_provider.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/components/occupation_dropdown.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/components/stepper_textfield.dart';

import '../../../controllers/validator.dart';

class RenterInfoStepper extends StatelessWidget {
  RenterInfoStepper({
    Key? key,
  }) : super(key: key);
  int numOfMember = 2;

  final firstPageFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final alternatePhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final renterInfoProvider = Provider.of<NewRenterInfoProvider>(context);
    nameController.text = renterInfoProvider.renterName;
    renterInfoProvider.firstPageFormKey = firstPageFormKey;

    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    var occupationDropdown = const OccupationDropdown();

    return Form(
      //key needs to exposed to its parent which is NewRenterStepper
      key: renterInfoProvider.firstPageFormKey,
      child: Column(
        children: [
          StepperTextField(
            label: "গ্রাহকের নাম",
            isAstrics: true,
            textEditingController: nameController,

            validationFunciton: Validator
                .checkRenterName, // validation is a class which contains
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
                  validationFunciton: Validator.checkPhoneNumber,
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
                  validationFunciton: Validator.checkPhoneNumber,
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
                      context.read<NewRenterInfoProvider>().incrementMember();
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    renterInfoProvider.memberNo,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IconButton(
                    iconSize: 22,
                    onPressed: () {
                      context.read<NewRenterInfoProvider>().decrementMember();
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
          buildChips(),
        ],
      ),
    );
  }

  Widget buildChips() => Wrap(
        children: const [
          ChoiceChip(
            selected: true,
            elevation: 3,
            avatar: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text('1A'),
            ),
            label: Text('আশরাফুল আলম'),
          ),
          Chip(
            elevation: 3,
            avatar: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text('1B'),
            ),
            label: Text('রবিউল ইসলাম'),
          ),
          Chip(
            elevation: 3,
            avatar: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text('2A'),
            ),
            label: Text('মাইনুল হোসেন'),
          ),
          Chip(
            elevation: 3,
            avatar: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text('2B'),
            ),
            label: Text('সাইফুল'),
          ),
        ],
      );
}
