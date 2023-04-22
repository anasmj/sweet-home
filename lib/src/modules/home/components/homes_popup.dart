import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/src/model/home_model.dart';

// ignore: must_be_immutable
class HomesPopupButton extends StatelessWidget {
  HomesPopupButton({
    required this.onHomeDelete,
    required this.userHomes,
    super.key,
  });
  VoidCallback onHomeDelete;
  List<Home> userHomes;

  @override
  Widget build(BuildContext context) {
    // Home? currentHome = context.watch<CurrentHomeProvider>().currentHome;
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
                  // context.read<CurrentHomeProvider>().setCurrentHome = homeObj;
                  // Provider.of<FlatListViewModel>(context, listen: false)
                  //     .configureFltas();
                  Navigator.pop(context);
                },
                value: homeObj.homeId,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      homeObj.homeName,
                    ),
                    // currentHome!.homeId == homeObj.homeId
                    //     ? getCheckIcon()
                    //     : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ).toList()),
    );
  }

  Widget getCheckIcon() {
    return Builder(builder: (context) {
      bool isDark = false;
      // Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
      return Icon(
        Icons.check_circle,
        color: isDark ? Colors.grey.shade900 : Colors.blue,
        size: 22,
      );
    });
  }
}
