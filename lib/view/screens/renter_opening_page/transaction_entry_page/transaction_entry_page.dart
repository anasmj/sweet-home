import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/flat_model.dart';
import '../../../../providers/flat_info_provider.dart';
import '../components/bottom_button.dart';
import 'components/payer_name_button.dart';
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
        const SizedBox(height: 20),
        const PayerNameButton(),
        Text(
          'এর মাধ্যমে',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: BottomButton(
            text: 'বুঝে পেলাম',
          ),
        ),
      ],
    );
  }
}
