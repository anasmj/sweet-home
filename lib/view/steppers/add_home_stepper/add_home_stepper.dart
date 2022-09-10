import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/new_home_step_provider.dart';
import 'package:sweet_home/view/steppers/add_home_stepper/steps_pages/confirmation_home_page.dart';
import 'package:sweet_home/view/steppers/add_home_stepper/steps_pages/first_page.dart';
import 'package:sweet_home/view/steppers/add_home_stepper/steps_pages/second_page.dart';
import '../../../models/response.dart';
import '../../../services/database_service/home_crud.dart';
import '../../app_widgets.dart';
import '../../resources/app_icons.dart';

class AddHomeStepper extends StatefulWidget {
  const AddHomeStepper({super.key});
  @override
  State<AddHomeStepper> createState() => _AddHomeStepperState();
}

class _AddHomeStepperState extends State<AddHomeStepper> {
  int _currentStep = 0;
  bool isCompletedd = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewHomeStepProvider>();
    //needs to be changed
    final bool isLastStep = getSteps().length - 1 == _currentStep;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'নতুন বাড়ি যুক্ত',
        ),
        centerTitle: true,
        // disable back button when user not in first page
        automaticallyImplyLeading: _currentStep != 0 ? false : true,
      ),
      body: !isCompletedd
          ? isLoading
              ? Center(
                  child: Lottie.asset(
                    AppIcons.blueCircleIndicator,
                    height: 150,
                    repeat: true,
                  ),
                )
              : Stepper(
                  type: StepperType.horizontal,
                  currentStep: _currentStep,
                  onStepContinue: () async {
                    if (isLastStep) {
                      setState(() {
                        isLoading = true;
                      });
                      //all informations are okay
                      if (context
                          .read<NewHomeStepProvider>()
                          .secondPageFormKey!
                          .currentState!
                          .validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        Response res = await HomeCrud().addHome(
                          homeName: provider.homeNameController.text,
                          location: provider.addressController.text,
                          rentAmount:
                              double.parse(provider.rentController.text),
                          gasBill: provider.waterController.text.isNotEmpty
                              ? double.parse(provider.gasController.text)
                              : 0.0,
                          waterBill: provider.waterController.text.isNotEmpty
                              ? double.parse(provider.waterController.text)
                              : 0.0,
                          numOfFloor: provider.floorLength,
                          flatPerFloor: provider.flatLength,
                        );

                        // Successful
                        if (res.code == 200) {
                          setState(() {
                            isCompletedd = true;
                            provider.clearControllers();
                          });

                          //failed
                        } else {
                          AppWidget.snackBarContent(
                              msg: res.body ?? 'বাড়ী যুক্ত করা সম্ভব হয়নি');
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                      //NOT LAST STEP
                    } else {
                      //first step
                      if (context
                          .read<NewHomeStepProvider>()
                          .firstPageFormKey!
                          .currentState!
                          .validate()) {
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
                  controlsBuilder: (context, ControlsDetails details) =>
                      Padding(
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
              isLastStep ? 'যুক্ত করি' : 'পরবর্তী',
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
