import 'package:flutter/material.dart';
import 'components/calender_button.dart';
import 'components/input_textfield.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: InputTextField(),
        ),
        const CalenderButton(),
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
