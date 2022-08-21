import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_home/providers/newrenter_step_provider.dart';

class OccupationDropdown extends StatefulWidget {
  const OccupationDropdown({super.key});

  @override
  State<OccupationDropdown> createState() => _OccupationDropdownState();
}
//    Provider.of<NewRenterInfoProvider>(context).setOccupation = value!;

// String? value;
String? dropDownValue = 'চাকরিজীবি';

class _OccupationDropdownState extends State<OccupationDropdown> {
  @override
  Widget build(BuildContext context) {
    Provider.of<NewRenterStepProvider>(context).setOccupation = dropDownValue!;

    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      value: dropDownValue,
      elevation: 10,
      onChanged: (String? newValue) => setState(() {
        // value = newValue;
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
