import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/utils/routes.dart';
import 'package:sweet_home/providers/dropdown_provider.dart';
import '../../../../models/home_summary.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../services/database_service/home_crud.dart';

// ignore: must_be_immutable
class HomeDropdown extends StatelessWidget {
  HomeDropdown({super.key});

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<ThemeProvider>().isDarkMode;
    final providerWatch = context.watch<DropdownProvider>();
    DropdownProvider providerRead = context.read<DropdownProvider>();

    final Color dropdownColorinDark = Colors.grey.shade700;
    final Color dropdownColorinLight = Colors.blue.shade200;

    return StreamBuilder<List<HomeSummary>?>(
      stream: HomeCrud().getHOmes(),
      builder: (context, AsyncSnapshot<List<HomeSummary>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData) {}
        final homes = snapshot.data;
        if (homes!.isEmpty) return showAddHomeWidget(context);
        if (providerWatch.currentHomeName == null) {
          providerRead.setCurrentHomeName = homes.first.homeName!;
          // providerRead.setCurrentHomeId = homes.first.homeId!;
          providerRead.updateHomeId(homes.first.homeId!);
        }

        dropdownValue = providerWatch.currentHomeName;
        return getDropdown(
          isDark,
          dropdownColorinDark,
          dropdownColorinLight,
          context,
          providerRead,
          homes,
        );
      },
    );
  }

  Widget getDropdown(
    bool isDark,
    Color dropdownColorinDark,
    Color dropdownColorinLight,
    BuildContext context,
    DropdownProvider providerRead,
    List<HomeSummary> homes,
  ) {
    return Builder(builder: (context) {
      final providerWatch = context.watch<DropdownProvider>();
      DropdownProvider providerRead = context.read<DropdownProvider>();

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
            value: dropdownValue,
            borderRadius: BorderRadius.circular(10),
            dropdownColor: isDark ? dropdownColorinDark : dropdownColorinLight,
            icon: Icon(
              Icons.expand_more,
              color: isDark ? Colors.white : Colors.grey.shade900,
            ),
            iconSize: 24,
            elevation: 19,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
            onChanged: (String? value) {
              providerRead.updateHomeName(value!);
              homes.forEach((home) {
                if (home.homeName == providerWatch.currentHomeName) {
                  //UPDATE SELECTED HOME
                  providerRead.updateHomeId(home.homeId!);
                }
              });
            },
            items: homes.map<DropdownMenuItem<String>>((HomeSummary home) {
              return DropdownMenuItem<String>(
                value: home.homeName,
                child: Text(home.homeName ?? ''),
              );
            }).toList(),
          ),
          IconButton(
            onPressed: () {
              AppRoute.getCurrentHomeInfo(context);
            },
            icon: const Icon(Icons.home),
            iconSize: 25,
            color: context.watch<ThemeProvider>().isDarkMode
                ? Colors.white
                : Colors.black.withOpacity(0.5),
          ),
        ],
      );
    });
  }

  InkWell showAddHomeWidget(BuildContext context) {
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
