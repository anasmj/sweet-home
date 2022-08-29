import 'package:flutter/material.dart';
import 'package:sweet_home/views/steppers/add_home_stepper/steps_pages/confirmation_home_page.dart';
import 'package:sweet_home/views/steppers/add_home_stepper/steps_pages/first_page.dart';
import 'package:sweet_home/views/steppers/add_home_stepper/steps_pages/second_page.dart';

class AddHomeStepper extends StatefulWidget {
  const AddHomeStepper({super.key});
  @override
  State<AddHomeStepper> createState() => _AddHomeStepperState();
}

class _AddHomeStepperState extends State<AddHomeStepper> {
  int _currentStep = 0;
  bool isCompletedd = false;
  bool isValidInfo = false;

  @override
  Widget build(BuildContext context) {
    //needs to be changed
    final bool isLastStep = getSteps().length - 1 == _currentStep;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'নতুন বাড়ি যুক্ত',
        ),
        centerTitle: true,
        //disable back button when user not in first page
        // automaticallyImplyLeading: _currentStep != 0
        //     ? false
        //     : true,
      ),
      body: !isCompletedd
          ? Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              onStepContinue: () {
                if (isLastStep) {
                  setState(() {
                    isCompletedd = true;
                    //logic to make a new home
                  });
                } else {
                  if (true) {
                    //renterInfoProvider.firstPageFormKey!.currentState.validate()
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
                      child: forwardNavigationButton(
                          context: context,
                          details: details,
                          isLastStep: isLastStep),
                    ),
                  ],
                ),
              ),
            )
          //confirm user that home is addeed
          : const ConfirmHomePage(),
    );
  }

  ElevatedButton forwardNavigationButton(
      {required BuildContext context,
      required ControlsDetails details,
      required bool isLastStep}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: details.onStepContinue,
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

  ElevatedButton backNavigationButton(ControlsDetails details) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.grey,
      ),
      onPressed: details.onStepCancel,
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

  List<Step> getSteps() => <Step>[
        Step(
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 0,
          title: const Text('বাড়ীর তথ্যাবলী'),
          content: FristPage(),
        ),
        Step(
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
          title: const Text('বিলসমূহ'),
          content: SecondPage(),
        ),
      ];
}
