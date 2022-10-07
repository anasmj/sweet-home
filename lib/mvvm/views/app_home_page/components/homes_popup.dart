import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';

import '../../../models/home_model.dart';
import '../../../providers/current_home.dart';

// ignore: must_be_immutable
class HomesPopupButton extends StatelessWidget {
  HomesPopupButton(
      {required this.onHomeDelete, required this.userHomes, super.key});
  VoidCallback onHomeDelete;
  List<Home> userHomes;

  @override
  Widget build(BuildContext context) {
    Home? currentHome = context.watch<CurrentHomeProvider>().currentHome;
    return PopupMenuButton(
      color: Theme.of(context).primaryColor,
      iconSize: 22,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: ((context) => userHomes.map(
            (homeObj) {
              return PopupMenuItem(
                onTap: () {
                  updateHome(context, homeObj);
                  Provider.of<FlatListViewModel>(context, listen: false)
                      .configureFltas(homeObj.homeId);
                },
                value: homeObj.homeId,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      homeObj.homeName,
                    ),
                    currentHome!.homeId == homeObj.homeId
                        ? getCheckIcon(context)
                        : const SizedBox(),
                  ],
                ),
              );
            },
          ).toList()),
    );
  }

  Icon getCheckIcon(context) {
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Icon(
      Icons.check_circle,
      color: isDark ? Colors.grey.shade900 : Colors.blue,
      size: 22,
    );
  }

  void updateHome(context, Home home) {
    Provider.of<CurrentHomeProvider>(context, listen: false).setCurrentHome =
        home;
  }
}
