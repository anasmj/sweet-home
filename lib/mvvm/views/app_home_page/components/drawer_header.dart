import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
import 'package:sweet_home/mvvm/views/app_home_page/components/homes_popup.dart';
import 'package:sweet_home/prev/providers/profile.dart';

class Drawerheader extends StatelessWidget {
  const Drawerheader({super.key});
  final double containerHeight = 200;

  @override
  Widget build(BuildContext context) {
    List<Home> homeList = context.watch<HomeListViewModel>().homeList;
    bool isDark = context.watch<ThemeProvider>().isDarkMode;
    String currentHomeName =
        context.watch<CurrentHomeProvider>().currentHome?.homeName ?? '';

    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.grey.shade900, Colors.grey.shade900]
              : [Colors.blue.shade400, Colors.blue.shade800],
        ),
      ),
      height: containerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              currentHomeName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          // const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getNameAndEmail(),
                homeList.isNotEmpty
                    ? HomesPopupButton(
                        onHomeDelete: () {
                          Navigator.of(context).pop();
                        },
                        userHomes: homeList)
                    : const SizedBox.shrink(),
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox getNameAndEmail() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Profile.userName ?? 'Name not found',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            Profile.email ?? 'no email',
          ),
        ],
      ),
    );
  }
}
