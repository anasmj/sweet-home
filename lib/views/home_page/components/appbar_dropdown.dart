import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/home_summary.dart';
import '../../../providers/theme_provider.dart';
import '../../../services/home_crud.dart';

class TitleDropdown extends StatelessWidget {
  TitleDropdown({super.key});

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeProvider>();
    final providerWatch = context.watch<HomeSummary>();
    final providerRead = context.read<HomeSummary>();

    return FutureBuilder<List<HomeSummary>?>(
      future: HomeCrud().getHOmes(),
      builder: (context, AsyncSnapshot<List<HomeSummary>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          final homes = snapshot.data;
          if (homes!.isEmpty) print('need to add home');
          if (providerRead.currentHome == null) {
            providerWatch.setCurrentHome = homes[0].homeName!;
          }

          dropdownValue = providerWatch.currentHome;
          return DropdownButton(
            value: dropdownValue,
            borderRadius: BorderRadius.circular(10),
            dropdownColor:
                mode.isDarkMode ? Colors.grey.shade700 : Colors.blue[200],
            icon: const Icon(Icons.expand_more),
            iconSize: 24,
            elevation: 19,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
            onChanged: (String? value) {
              // setState(() {
              //   dropdownValue = value;
              // });

              providerRead.updateHomeName(value!);
            },
            items: homes.map<DropdownMenuItem<String>>((HomeSummary home) {
              return DropdownMenuItem<String>(
                value: home.homeName,
                child: Text(home.homeName ?? ''),
              );
            }).toList(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
