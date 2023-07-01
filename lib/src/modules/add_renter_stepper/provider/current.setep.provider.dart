import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/new_home_stepper/provider/new.home.provider.dart';

import '../steps_pages/first_step.dart';
import '../steps_pages/second_step.dart';
import '../steps_pages/third_step.dart';

final newRenterStepProvider = NotifierProvider<CurrentStepperProvider, int>(
  CurrentStepperProvider.new,
);

class CurrentStepperProvider extends Notifier<int> {
  bool isCompleted = false;
  bool isLoading = false;
  ControlsDetails? stepperDetails;
  @override
  int build() {
    return 0;
  }

  void setControllerDetail(ControlsDetails detail) {
    stepperDetails = detail;
  }

  void onStepContinue() async {
    final bool isLastStep = steps().length - 1 == state;

    if (isLastStep) {
      if (!await ref.read(newHomeProvider.notifier).onAddHome()) return;
      isCompleted = true;
      return;
    }

    state = state + 1;
  }

  void onStepCancel() {
    if (state == 0) return;

    state = state - 1;
  }

  List<Step> steps() => <Step>[
        Step(
          state: state > 0 ? StepState.complete : StepState.indexed,
          isActive: state >= 0,
          title: const Text('তথ্য'),
          content: RenterInfoStep(),
        ),
        Step(
          state: state > 1 ? StepState.complete : StepState.indexed,
          isActive: state >= 1,
          title: const Text('ঠিকানা'),
          content: AddressStep(),
        ),
        Step(
          state: state > 2 ? StepState.complete : StepState.indexed,
          isActive: state >= 2,
          title: const Text('পেমেন্ট'),
          content: ThirdStepPage(),
        ),
      ];
}
