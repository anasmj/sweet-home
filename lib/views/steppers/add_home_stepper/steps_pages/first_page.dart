import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/views/steppers/shared_components/stepper_textfield.dart';

import '../components/counter.dart';

class FristPage extends StatelessWidget {
  FristPage({super.key});
  final homeNameController = TextEditingController();
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
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
        StepperTextField(textEditingController: homeNameController),
        const SizedBox(
          height: 20,
        ),
        const Text('ঠিকানা'),
        StepperTextField(textEditingController: addressController),
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
    );
  }
}
