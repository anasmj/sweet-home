import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';

import '../../../../../view_models/new_renter_view_model.dart';

class OccupationDropdown extends StatefulWidget {
  const OccupationDropdown({super.key});

  @override
  State<OccupationDropdown> createState() => _OccupationDropdownState();
}
//  Provider.of<NewRenterInfoProvider>(context).setOccupation = value!;

// String? value;
String? dropDownValue = 'চাকরিজীবি';

final Color dropdownColorLight = Colors.grey.shade200;
final Color dropdownColorDark = Colors.grey.shade800;

class _OccupationDropdownState extends State<OccupationDropdown> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewRenterViewModel>(context);

    provider.setOccupation(occupation: dropDownValue!);

    return DropdownButton(
      dropdownColor: context.watch<ThemeProvider>().isDarkMode
          ? dropdownColorDark
          : dropdownColorLight,
      borderRadius: BorderRadius.circular(10),
      value: dropDownValue,
      elevation: 10,
      onChanged: (String? newValue) => setState(() {
        dropDownValue = newValue;
        provider.setOccupation(occupation: newValue!);
      }),
      items: provider.occupationOptions
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                // style: formTextStyle,
              ),
            ),
          )
          .toList(),
    );
  }
}
