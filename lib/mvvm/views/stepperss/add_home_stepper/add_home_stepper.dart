import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/views/stepperss/add_home_stepper/steps_pages/confirmation_home_page.dart';
import 'package:sweet_home/mvvm/views/stepperss/add_home_stepper/steps_pages/first_page.dart';
import 'package:sweet_home/mvvm/views/stepperss/add_home_stepper/steps_pages/second_page.dart';
import 'package:sweet_home/mvvm/views/stepperss/add_renter_stepper/steps_pages/components/nav_buttons.dart';
import '../../../models/response.dart';
import '../../../services/home_services.dart';
import '../../../view_models/home_stepper_view_model.dart';
import '../../../../prev/utils/user_flat.dart';
import '../../../../prev/view/screens/waiting_pages/making_home_indicator.dart';
import '../../app_widgets.dart';

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
    final provider = context.watch<HomeStepperProviderViewModel>();
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
              ? const MakingHomeIndicator()
              : Stepper(
                  type: StepperType.horizontal,
                  currentStep: _currentStep,
                  onStepContinue: () async {
                    if (isLastStep) {
                      if (context
                          .read<HomeStepperProviderViewModel>()
                          .secondPageFormKey!
                          .currentState!
                          .validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        Response res = await HomeServices().addHome(
                          homeName: provider.homeNameController.text.trim(),
                          location: provider.addressController.text.trim(),
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
                          flatNames: UserFlats.getFlatList(
                            floorRange: provider.floorLength,
                            flatRange: provider.flatLength,
                          ),
                        );

                        // Successful
                        if (res.code == 200) {
                          // ignore: use_build_context_synchronously
                          Provider.of<CurrentHomeProvider>(context,
                                  listen: false)
                              .setUserHome();
                          provider.homeNameController.clear();
                          provider.addressController.clear();
                          provider.rentController.clear();
                          provider.waterController.clear();
                          provider.gasController.clear();

                          setState(() {
                            isCompletedd = true;

                            // provider.clearControllers();//todo: do it from here
                          });

                          //failed
                        } else {
                          AppWidget.showSnackBarWithMsg(
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
                          .read<HomeStepperProviderViewModel>()
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
                            child: BackNavButton(details: details),
                          ),

                        if (_currentStep != 0)
                          const SizedBox(
                            width: 20,
                          ),
                        Expanded(
                          child: ForwardNavButton(
                            details: details,
                            isLastStep: isLastStep,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
          //confirm user that home is addeed
          : const ConfirmPage(),
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
          content: const SecondPage(),
        ),
      ];
}
