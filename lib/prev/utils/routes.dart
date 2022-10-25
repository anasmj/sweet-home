import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/renter_opening_backup_page.dart';
import '../../mvvm/models/flat_model.dart';
import '../../mvvm/views/stepperss/add_home_stepper/add_home_stepper.dart';
import '../../mvvm/views/stepperss/add_renter_stepper/add_renter_stepper.dart';

class AppRoute {
  //DETAIL OF A FLAT FROM FLATLIST
  static void flatDetail(BuildContext context, Flat flat) => Navigator.push(
        context,
        PageTransition(
          child: FlatDetails(
            renter: flat.renter!,
          ),
          type: PageTransitionType.rightToLeft,
        ),
      );

  //HOME DETAIL PAGE
  // static void toCurrentHomeDetail(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => const UserHomes(),
  //     ),
  //   );
  // }

  //CREATE NEW FLAT
  static void newHomeStepper({required BuildContext context}) {
    Navigator.push(
      context,
      PageTransition(
        child: const AddHomeStepper(),
        type: PageTransitionType.fade,
      ),
    );
  }

  //ADD NEW RENTER
  static void newRenterStepper({required BuildContext context}) {
    Navigator.push(
      context,
      PageTransition(
        child: const AddRenterStepper(),
        type: PageTransitionType.fade,
      ),
    );
    // context.read<NewRenterStepProvider>().setSelectedFlatNo(flatNo);
  }
}
