import 'package:flutter/material.dart';

import 'package:rent_home/views/steppers/new_renter_stepper/steps_pages/second_step.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/steps_pages/third_step.dart';
import 'package:rent_home/views/steppers/new_renter_stepper/steps_pages/first_step.dart';
import 'package:rent_home/providers/newrenter_step_provider.dart';
import 'package:provider/provider.dart';

class NewRenterStepper extends StatefulWidget {
  const NewRenterStepper({super.key});

  @override
  State<NewRenterStepper> createState() => _AddNewRenterStepperState();
}

class _AddNewRenterStepperState extends State<NewRenterStepper> {
  int _currentStep = 0;
  bool isCompletedd = false;
  bool isValidInfo = false;
  @override
  Widget build(BuildContext context) {
    final renterInfoProvider = Provider.of<NewRenterStepProvider>(
        context); //used to validate state of form
    final bool isLastStep = getSteps().length - 1 == _currentStep;

    return Scaffold(
      appBar: AppBar(
        title: const Text('নতুন গ্রাহক যুক্ত'),
        centerTitle: true,
      ),
      body: !isCompletedd
          ? Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              onStepContinue: () {
                if (isLastStep) {
                  setState(() {
                    isCompletedd = true;
                  });
                  print('completed');
                } else {
                  if (renterInfoProvider.firstPageFormKey!.currentState!
                      .validate()) {
                    //false if textfield value of first pagd is not valied.
                    setState(() {
                      _currentStep += 1;
                    });
                  }
                }
              },
              onStepCancel: () => _currentStep == 0
                  ? null
                  : setState(() {
                      _currentStep -= 1;
                    }),
              steps: getSteps(),
              controlsBuilder: (context, ControlsDetails details) => Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //dont show back button at first step
                    if (_currentStep != 0)
                      Expanded(
                        child: backNavigationButton(details),
                      ),
                    if (_currentStep != 0)
                      const SizedBox(
                        width: 20,
                      ),
                    Expanded(
                      child: forwardNavigationButton(details, isLastStep),
                    ),
                  ],
                ),
              ),
            )
          //user added a new renter into the flat.
          : const Center(
              child: Text('successful'),
            ),
    );
  }

  ElevatedButton forwardNavigationButton(
      ControlsDetails details, bool isLastStep) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: details.onStepContinue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isLastStep ? 'যুক্ত করি' : 'সামনে যাই',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            width: 8,
          ),
          if (!isLastStep)
            const Icon(
              Icons.arrow_forward_rounded,
            ),
        ],
      ),
    );
  }

  ElevatedButton backNavigationButton(ControlsDetails details) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.grey,
      ),
      onPressed: details.onStepCancel,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.arrow_back_rounded,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'পেছনে',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  List<Step> getSteps() => <Step>[
        Step(
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 0,
          title: const Text('তথ্য'),
          content: RenterInfoStep(),
        ),
        Step(
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
          title: const Text('ঠিকানা'),
          content: AddressStep(),
        ),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
          title: const Text('ছবি'),
          content: const ThirdStepPage(),
        ),
      ];
}
