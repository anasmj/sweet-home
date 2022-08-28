import 'package:flutter/material.dart';
import 'package:sweet_home/views/steppers/add_renter_stepper/steps_pages/components/occupation_dropdown.dart';
import 'package:sweet_home/views/steppers/add_renter_stepper/steps_pages/components/stepper_textfield.dart';

import '../../shared_components/stepper_textfield.dart';
import 'components/location_radio.dart';

class AddressStep extends StatelessWidget {
  AddressStep({
    Key? key,
  }) : super(key: key);
  int numOfMember = 2;
  final addressFormKey = GlobalKey<FormState>();

  final previousAddressController = TextEditingController();
  final permanentAddressController = TextEditingController();
  final vilageController = TextEditingController();
  final unionController = TextEditingController();
  final subDistrictController = TextEditingController();
  final districtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    var occupationDropdown = OccupationDropdown();
    return Form(
      child: Column(
        children: [
          StepperTextField(
            label: "পূর্বের ঠিকানা",
            textEditingController: previousAddressController,
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'স্থায়ী ঠিকানা',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          StepperTextField(
            label: 'গ্রাম',
            textEditingController: vilageController,
          ),
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const LocationRadio(),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: StepperTextField(
                  textEditingController: unionController,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          StepperTextField(
            label: 'উপজেলা',
            textEditingController: subDistrictController,
          ),
          const SizedBox(
            height: 10,
          ),
          StepperTextField(
            label: 'জেলা',
            textEditingController: districtController,
          ),
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
