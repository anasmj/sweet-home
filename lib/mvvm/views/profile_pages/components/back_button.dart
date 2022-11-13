import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/add_renter_view_model.dart';

class ProfileBackButton extends StatelessWidget {
  const ProfileBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final renterProvider = context.read<AddRenterViewModel>();

    return IconButton(
      onPressed: () {
        renterProvider.renterNameController.clear();
        renterProvider.previousLocationController.clear();
        renterProvider.villageController.clear();
        renterProvider.subDistrictController.clear();
        renterProvider.districtController.clear();
        renterProvider.occupationController.clear();
        renterProvider.noOfMemberController.clear();
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back_ios_sharp),
    );
  }
}
