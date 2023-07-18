import 'package:flutter/material.dart';

class ProfileBackButton extends StatelessWidget {
  const ProfileBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // renterProvider.renterNameController.clear();
        // renterProvider.previousLocationController.clear();
        // renterProvider.villageController.clear();
        // renterProvider.subDistrictController.clear();
        // renterProvider.districtController.clear();
        // renterProvider.occupationController.clear();
        // renterProvider.noOfMemberController.clear();
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back_ios_sharp),
    );
  }
}
