import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/new_home_stepper/provider/stepper.provider.dart';
import 'package:sweet_home/src/modules/user.house/provider/isLoading.provider.dart';
import '../components/making.home.indicator.dart';
import '../components/stepper.navigation.dart';
import 'confirmation.page/confirmation_home_page.dart';

class AddHomeStepper extends ConsumerWidget {
  const AddHomeStepper({super.key});

  @override
  Widget build(BuildContext context, ref) {
    //needs to be changed
    bool isCompleted = ref.watch(currentStepNotifier.notifier).isCompleted;
    int currentStep = ref.watch(currentStepNotifier);
    bool isLoading = ref.watch(isLoadingNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'নতুন বাড়ি যুক্ত',
        ),
        centerTitle: true,
        // disable back button when user not in first page
        automaticallyImplyLeading: currentStep != 0 ? false : true,
      ),
      body: !isCompleted
          ? isLoading
              ? const MakingHomeIndicator()
              : Stepper(
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepContinue:
                      ref.read(currentStepNotifier.notifier).onStepContinue,
                  onStepCancel:
                      ref.read(currentStepNotifier.notifier).onStepCancel,
                  steps: ref.watch(currentStepNotifier.notifier).steps(),
                  controlsBuilder: (context, ControlsDetails details) {
                    ref
                        .read(currentStepNotifier.notifier)
                        .setControllerDetail(details);
                    return const StepperNavigation();
                  },
                )

          //confirm user that home is addeed
          : const ConfirmPage(),
    );
  }
}
