import 'package:flutter/material.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/components/occupation_dropdown.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/components/stepper_textfield.dart';

import 'components/location_radio.dart';

class AddressStepper extends StatelessWidget {
  AddressStepper({
    Key? key,
  }) : super(key: key);
  int numOfMember = 2;

  @override
  Widget build(BuildContext context) {
    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    var occupationDropdown = OccupationDropdown();
    return Column(
      children: [
        StepperTextField(
          label: "পূর্বের ঠিকানা",
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
              child: StepperTextField(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        StepperTextField(label: 'উপজেলা'),
        const SizedBox(
          height: 10,
        ),
        StepperTextField(label: 'জেলা'),
      ],
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
