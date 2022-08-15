import 'package:flutter/material.dart';
import '../../app_icons.dart';
import 'components/calender_button.dart';
import 'components/input_textfield.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        InputTextField(),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: CalenderButton(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          //TODO: desable when textfield is empty => onPressed: null
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minWidth: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            color: Theme.of(context).secondaryHeaderColor,
            disabledColor: Colors.grey,
            onPressed: () {},
            child: Text(
              'বুঝে পেলাম',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ],
    );
  }
}
