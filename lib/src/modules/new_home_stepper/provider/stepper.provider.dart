import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/new_home_stepper/provider/new.home.provider.dart';
import '../view/fist.page/first_page.dart';
import '../view/second.page/second_page.dart';

final currentStepNotifier = NotifierProvider<CurrentStepperProvider, int>(
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
      if (!await ref.read(newHomeNotifier.notifier).onAddHome()) return;
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
          title: const Text('বাড়ীর তথ্যাবলী'),
          content: const FristPage(),
        ),
        Step(
          state: state > 1 ? StepState.complete : StepState.indexed,
          isActive: state >= 1,
          title: const Text('বিলসমূহ'),
          content: const SecondPage(),
        ),
      ];
}
