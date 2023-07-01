import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/stepper.textfield/stepper_textfield.dart';
import 'package:sweet_home/src/modules/user.house/provider/isLoading.provider.dart';
import 'package:sweet_home/src/utils/form_validators.dart';

import '../../provider/new.home.provider.dart';

class SecondPage extends ConsumerWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'বিলসমূহ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Divider(
            color: Colors.grey[900],
          ),
          const SizedBox(
            height: 20,
          ),
          // RentAmountField(formTextStyle: formTextStyle, provider: provider),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Gas',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: ref.read(newHomeProvider.notifier).onGasChange,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Water',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: ref.read(newHomeProvider.notifier).onWaterChange,
                ),
              ),
            ],
          ),

          // GasField(provider: provider),
          // WaterBillField(provider: provider),
          const SizedBox(
            height: 20,
          ),
          Text(ref.watch(isLoadingNotifier).toString()),
        ],
      ),
    );
  }
}

class RentAmountField extends StatelessWidget {
  const RentAmountField({
    super.key,
    required this.formTextStyle,
  });

  final TextStyle? formTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(text: 'ভাড়া', style: formTextStyle),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: StepperTextField(
            validationFunciton: FormValidators.checkRentAmount,
            isNumeric: true,
          ),
        ),
      ],
    );
  }
}
