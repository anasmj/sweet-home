import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/stepper.provider.dart';

class StepperNavigation extends ConsumerWidget {
  const StepperNavigation({super.key});

  @override
  Widget build(BuildContext context, ref) {
    int currentStep = ref.watch(currentStepNotifier);
    final details = ref.watch(currentStepNotifier.notifier).stepperDetails;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
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
              details: details,
              isLastStep: false,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ForwardNavButton extends StatelessWidget {
  ForwardNavButton({
    super.key,
    required this.details,
    required this.isLastStep,
  });
  ControlsDetails? details;
  bool isLastStep;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: details?.onStepContinue,
      // provider.selectedFlatNo != null ? details.onStepContinue : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLastStep ? 'যুক্ত করি' : 'সামনে যাই',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              width: 6,
            ),
            if (!isLastStep)
              const Icon(
                Icons.arrow_forward_rounded,
              ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BackNavButton extends StatelessWidget {
  BackNavButton({super.key, required this.details});
  ControlsDetails? details;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        side: const BorderSide(
          color: Colors.blue,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // backgroundColor: Colors.grey,
      ),
      onPressed: details?.onStepCancel,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.arrow_back_rounded,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'পেছনে',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
