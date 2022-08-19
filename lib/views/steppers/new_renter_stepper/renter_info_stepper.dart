import 'package:flutter/material.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/components/occupation_dropdown.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/components/stepper_textfield.dart';

class RenterInfoStepper extends StatelessWidget {
  RenterInfoStepper({
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
          label: "গ্রাহকের নাম",
          isAstrics: true,
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
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: StepperTextField(
                isPhoneNumber: true,
                label: "বিকল্প ফোন নম্বর",
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
            Column(
              children: [
                IconButton(
                  iconSize: 22,
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                Text(
                  '2',
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconButton(
                  iconSize: 22,
                  onPressed: () {},
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
