import 'package:flutter/material.dart';
import '../components/bottom_button.dart';
import 'components/transaction_date_picker.dart';
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
        const InputTextField(),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: TransactionDatePicker(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          //TODO: desable when textfield is empty => onPressed: null
          child: BottomButton(
            text: 'বুঝে পেলাম',
          ),
        ),
      ],
    );
  }
}
