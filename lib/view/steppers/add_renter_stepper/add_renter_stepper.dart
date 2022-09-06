import 'package:flutter/material.dart';
import 'package:sweet_home/view/steppers/add_renter_stepper/steps_pages/confirmation_page.dart';
import 'package:sweet_home/view/steppers/add_renter_stepper/steps_pages/second_step.dart';
import 'package:sweet_home/view/steppers/add_renter_stepper/steps_pages/third_step.dart';
import 'package:sweet_home/view/steppers/add_renter_stepper/steps_pages/first_step.dart';
import 'package:sweet_home/providers/newrenter_step_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/renter_management.dart';

class AddRenterStepper extends StatefulWidget {
  const AddRenterStepper({super.key});
  @override
  State<AddRenterStepper> createState() => _AddAddRenterStepperState();
}

class _AddAddRenterStepperState extends State<AddRenterStepper> {
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
        automaticallyImplyLeading: _currentStep != 0
            ? false
            : true, //disable back button when user not in first page
      ),
      body: !isCompletedd
          ? Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              onStepContinue: () {
                if (isLastStep) {
                  setState(() {
                    isCompletedd = true;
                    //logic to make a new renter object and add to lists
                    RenterManagement.addRenterToFlat(
                        context: context); //flat no is up to dated in provider
                  });
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
                      child: forwardNavigationButton(
                          context: context,
                          details: details,
                          isLastStep: isLastStep),
                    ),
                  ],
                ),
              ),
            )
          //user added a new renter into the flat.
          : const ConfirmationPage(),
    );
  }

  ElevatedButton forwardNavigationButton(
      {required BuildContext context,
      required ControlsDetails details,
      required bool isLastStep}) {
    final provider = Provider.of<NewRenterStepProvider>(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed:
          provider.selectedFlatNo != null ? details.onStepContinue : null,
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
          content: ThirdStepPage(),
        ),
      ];
}
