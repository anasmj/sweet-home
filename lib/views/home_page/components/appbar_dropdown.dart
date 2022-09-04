import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/controllers/routes.dart';
import 'package:sweet_home/providers/dropdown_provider.dart';
import 'package:sweet_home/providers/home_provider.dart';
import 'package:sweet_home/views/steppers/add_home_stepper/add_home_stepper.dart';

import '../../../models/home_summary.dart';
import '../../../providers/theme_provider.dart';
import '../../../services/home_crud.dart';

// ignore: must_be_immutable
class TitleDropdown extends StatelessWidget {
  TitleDropdown({super.key});

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeProvider>();
    final providerWatch = context.watch<DropdownProvider>();
    final providerRead = context.read<DropdownProvider>();

    return StreamBuilder<List<HomeSummary>?>(
      stream: HomeCrud().getHOmes(),
      builder: (context, AsyncSnapshot<List<HomeSummary>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          final homes = snapshot.data;
          if (homes!.isEmpty) {
            return emptyHomeWidget(context);
          }
          if (providerRead.currentHomeName == null) {
            providerWatch.setCurrentHomeName = homes[0].homeName!;
            providerRead.setCurrentHomeId = homes[0].homeId!;
          }

          dropdownValue = providerWatch.currentHomeName;

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
              providerRead.updateHomeName(value!);
              homes.forEach((home) {
                if (home.homeName == providerWatch.currentHomeName) {
                  // print(home.homeId);
                  //update provider with new home
                  if (home.homeId != null) {
                    providerRead.setCurrentHomeId = home.homeId!;
                  }
                }
              });
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

  InkWell emptyHomeWidget(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute.newHomeStepper(context: context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('বাড়ী যুক্ত'),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.add),
        ],
      ),
    );
  }
}
