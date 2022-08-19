import 'package:flutter/material.dart';

class OccupationDropdown extends StatefulWidget {
  const OccupationDropdown({super.key});

  @override
  State<OccupationDropdown> createState() => _OccupationDropdownState();
}

String? value;
String? dropDownValue = 'চাকরিজীবি';

class _OccupationDropdownState extends State<OccupationDropdown> {
  @override
  Widget build(BuildContext context) {
    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    return DropdownButton(
      value: dropDownValue,
      elevation: 2,
      onChanged: (String? newValue) => setState(() {
        value = newValue;
        dropDownValue = newValue;
      }),
      items: ['চাকরিজীবি', 'ব্যাবসায়ী', 'অন্যান্য']
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: formTextStyle,
              ),
            ),
          )
          .toList(),
    );
  }
}
