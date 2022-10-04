import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/home_stepper_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../utils/form_validators.dart';
import '../../shared_components/stepper_textfield.dart';
import '../components/counter.dart';

class FristPage extends StatelessWidget {
  FristPage({super.key});
  final _firstPageFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeStepperProvider>(context);
    provider.firstPageFormKey = _firstPageFormKey;
    return Form(
      key: provider.firstPageFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'বাড়ীর তথ্যাবলী',
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
          const Text('বাড়ীর নাম'),
          StepperTextField(
            textEditingController: provider.homeNameController,
            validationFunciton: FormValidators.checkRenterName,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('ঠিকানা'),
          StepperTextField(
            textEditingController: provider.addressController,
            validationFunciton: FormValidators.checkLocation,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatFloorCounter(),
              FlatFloorCounter(
                isFlatCounter: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
