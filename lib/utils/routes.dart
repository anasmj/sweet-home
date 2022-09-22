import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/flat_model.dart';
import '../providers/newrenter_step_provider.dart';
import '../view/screens/renter_opening_page/renter_opening_backup_page.dart';
import 'get_user_homes.dart';
import '../view/steppers/add_home_stepper/add_home_stepper.dart';
import '../view/steppers/add_renter_stepper/add_renter_stepper.dart';

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
  static void toCurrentHomeDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserHomes(),
      ),
    );
  }

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
