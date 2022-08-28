import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/flat_model.dart';
import '../providers/newrenter_step_provider.dart';
import '../views/flat_details_page/flat_details.dart';
import '../views/steppers/add_home_stepper/add_home_stepper.dart';
import '../views/steppers/add_renter_stepper/add_renter_stepper.dart';

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

  //CREATE NEW FLAT
  static void newHomeStepper({required BuildContext context}) {
    Navigator.push(
      context,
      PageTransition(
        child: AddHomeStepper(),
        type: PageTransitionType.fade,
      ),
    );
  }

  //ADD NEW RENTER
  static void newRenterStepper(
      {required BuildContext context, required int flatNo}) {
    Navigator.push(
      context,
      PageTransition(
        child: AddRenterStepper(),
        type: PageTransitionType.fade,
      ),
    );
    context.read<NewRenterStepProvider>().setSelectedFlatNo(flatNo);
  }
}
