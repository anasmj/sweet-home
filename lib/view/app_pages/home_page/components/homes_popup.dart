import 'package:flutter/material.dart';
import '../../../../models/home_model.dart';

// ignore: must_be_immutable
class HomesPopupButton extends StatelessWidget {
  HomesPopupButton(
      {required this.onHomeDelete, required this.userHomes, super.key});
  VoidCallback onHomeDelete;
  List<Home> userHomes;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconSize: 22,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: ((context) => userHomes
          .map(
            (homeObj) => PopupMenuItem(
              value: homeObj.homeId,
              child: Text(homeObj.homeName),
            ),
          )
          .toList()),
    );
  }
}
