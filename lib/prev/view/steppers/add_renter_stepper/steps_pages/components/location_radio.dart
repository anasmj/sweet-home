import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/newrenter_step_provider.dart';

class LocationRadio extends StatefulWidget {
  const LocationRadio({super.key});

  @override
  State<LocationRadio> createState() => _LocationRadioState();
}

int _value = 0;

class _LocationRadioState extends State<LocationRadio> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewRenterStepProvider>();
    return Row(
      children: [
        Radio(
          value: 0,
          groupValue: _value,
          onChanged: (value) {
            setState(() {
              _value = value as int;
              provider.isThanaSelected = true;
            });
          },
        ),
        const Text('থানা'),
        Radio(
          value: 1,
          groupValue: _value,
          onChanged: (value) {
            setState(() {
              _value = value as int;
              provider.isThanaSelected = false;
            });
          },
        ),
        const Text('ইউনিয়ন'),
      ],
    );
  }
}
