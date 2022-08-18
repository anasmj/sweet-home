import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewRenterStepper extends StatefulWidget {
  const NewRenterStepper({super.key});

  @override
  State<NewRenterStepper> createState() => _AddNewRenterStepperState();
}

class _AddNewRenterStepperState extends State<NewRenterStepper> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final bool isLastStep = getSteps().length - 1 == _currentStep;

    return Scaffold(
      appBar: AppBar(
        title: const Text('নতুন গ্রাহক যুক্ত'),
        centerTitle: true,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (isLastStep) {
            print('completed');
          } else {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () => _currentStep == 0
            ? null
            : setState(() {
                _currentStep -= 1;
              }),
        type: StepperType.horizontal,
        steps: getSteps(),
        controlsBuilder: (context, ControlsDetails details) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_currentStep != 0)
              Expanded(
                child: ElevatedButton(
                  onPressed: details.onStepCancel,
                  child: const Text(
                    'পেছনে যাই',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            if (_currentStep != 0)
              const SizedBox(
                width: 20,
              ),
            Expanded(
              child: ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(
                  isLastStep ? 'যুক্ত করি' : 'নিশ্চিত',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Step> getSteps() => <Step>[
        Step(
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 0,
          title: const Text('তথ্য'),
          content: const Center(child: Text('weill')),
        ),
        Step(
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
          title: const Text('ঠিকানা'),
          content: const Center(child: Text('weill')),
        ),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
          title: const Text('ছবি'),
          content: const Center(child: Text('weill')),
        ),
      ];
}
