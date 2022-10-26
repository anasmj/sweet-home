import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';
import '../../../../view_models/home_stepper_view_model.dart';
import '../../../../utils/form_validators.dart';
import '../../components/stepper_textfield.dart';
import '../components/counter.dart';

class FristPage extends StatelessWidget {
  FristPage({super.key});
  final _firstPageFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeStepperProviderViewModel>(context);
    provider.firstPageFormKey = _firstPageFormKey;
    return Form(
      key: provider.firstPageFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'বাড়ীর তথ্যাবলী',
              style: Theme.of(context).textTheme.titleLarge,
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
            validationFunciton: FormValidators.checkHomeName,
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
