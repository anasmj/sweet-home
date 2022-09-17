import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/utils/form_validators.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/view/steppers/shared_components/stepper_textfield.dart';

import '../../../../providers/new_home_step_provider.dart';

class SecondPage extends StatefulWidget {
  SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _secondPageFormKey = GlobalKey<FormState>();

  bool? gasChecked = false;
  bool? waterChecked = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewHomeStepProvider>(context);
    provider.secondPageFormKey = _secondPageFormKey;

    TextStyle? formTextStyle = Theme.of(context).textTheme.subtitle1;
    return Form(
      key: provider.secondPageFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'বিলসমূহ',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Divider(
            color: context.watch<ThemeProvider>().isDarkMode
                ? Colors.white
                : Colors.grey[900],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
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
                  textEditingController: provider.rentController,
                  validationFunciton: FormValidators.checkRentAmount,
                  isNumeric: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'গ্যাস',
                  style: formTextStyle,
                ),
              ),
              Expanded(
                child: StepperTextField(
                  textEditingController: provider.gasController,
                  validationFunciton: FormValidators.checkGasBill,
                  isNumeric: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'পানি',
                  style: formTextStyle,
                ),
              ),
              Expanded(
                child: StepperTextField(
                  textEditingController: provider.waterController,
                  validationFunciton: FormValidators.checWaterBill,
                  isNumeric: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void emptyFiledValidator() {}
}
