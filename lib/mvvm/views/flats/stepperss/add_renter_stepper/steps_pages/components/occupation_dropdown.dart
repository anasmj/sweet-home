import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';

import '../../../../../../view_models/new_renter_view_model.dart';

class OccupationDropdown extends StatefulWidget {
  const OccupationDropdown({super.key});

  @override
  State<OccupationDropdown> createState() => _OccupationDropdownState();
}
//  Provider.of<NewRenterInfoProvider>(context).setOccupation = value!;

// String? value;
String? dropDownValue = 'চাকরিজীবি';
final List<String> items = ['চাকরিজীবি', 'ব্যাবসায়ী', 'অন্যান্য'];
final Color dropdownColorLight = Colors.grey.shade200;
final Color dropdownColorDark = Colors.grey.shade800;

class _OccupationDropdownState extends State<OccupationDropdown> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewRenterViewModel>(context);

    provider.setOccupation(dropDownValue!);
    // TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
    //       color: Colors.black.withOpacity(0.8),
    //     );
    return DropdownButton(
      dropdownColor: context.watch<ThemeProvider>().isDarkMode
          ? dropdownColorDark
          : dropdownColorLight,
      borderRadius: BorderRadius.circular(10),
      value: dropDownValue,
      // value: dropDownValue,
      elevation: 10,

      onChanged: (String? newValue) => setState(() {
        dropDownValue = newValue;
        provider.setOccupation(newValue!);
      }),
      items: items
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
