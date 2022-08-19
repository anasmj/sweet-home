import 'package:flutter/material.dart';

class LocationRadio extends StatefulWidget {
  const LocationRadio({super.key});

  @override
  State<LocationRadio> createState() => _LocationRadioState();
}

int _value = 0;

class _LocationRadioState extends State<LocationRadio> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: 0,
          groupValue: _value,
          onChanged: (value) {
            setState(() {
              _value = value as int;
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
            });
          },
        ),
        const Text('ইউনিয়ন'),
      ],
    );
  }
}
