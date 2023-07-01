import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart';

import 'components/adding_renter_indicator.dart';
import 'components/renter_add_successful.dart';
import 'provider/current.setep.provider.dart';
import 'steps_pages/components/nav_buttons.dart';

class AddRenterStepper extends ConsumerStatefulWidget {
  const AddRenterStepper({super.key});
  @override
  ConsumerState<AddRenterStepper> createState() => _AddAddRenterStepperState();
}

class _AddAddRenterStepperState extends ConsumerState<AddRenterStepper> {
  int currentStep = 0;
  bool isCompletedd = false;
  bool isLoading = false;
  // int? nIdNumber;
  double? advanceAmount;

  @override
  Widget build(BuildContext context) {
    final homeId = ref.watch(selectedHomeProvider)?.homeId;
    final stepNotifier = ref.watch(newRenterStepProvider.notifier);
    if (homeId == null) return emptyWidget;
    return Scaffold(
      appBar: AppBar(
        title: const Text('গ্রাহক যুক্ত করুন'),
        centerTitle: true,
        automaticallyImplyLeading: currentStep != 0
            ? false
            : true, //disable back button when user not in first pag
      ),
      body: !isCompletedd
          ? isLoading
              ? const AddingRenterIndicator()
              : Stepper(
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepContinue: stepNotifier.onStepContinue,
                  onStepCancel: stepNotifier.onStepContinue,
                  steps: ref.watch(newRenterStepProvider.notifier).steps(),
                  controlsBuilder: (context, ControlsDetails detail) {
                    stepNotifier.setControllerDetail(detail);
                    return const RenterStepperNavigation();
                  },
                )
          : const AddRenterSuccessfulPage(),
    );
  }
}

class RenterStepperNavigation extends ConsumerWidget {
  const RenterStepperNavigation({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final currentStep = ref.watch(newRenterStepProvider);
    final details = ref.watch(newRenterStepProvider.notifier).stepperDetails;
    final isLastStep =
        ref.watch(newRenterStepProvider.notifier).steps().length - 1 ==
            currentStep;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //dont show back button at first step
        if (currentStep != 0)
          Expanded(
            child: BackNavButton(details: details),
          ),
        if (currentStep != 0)
          const SizedBox(
            width: 20,
          ),
        Expanded(
          child: ForwardNavButton(
            details: details!,
            isLastStep: isLastStep,
          ),
        ),
      ],
    );
  }
}
