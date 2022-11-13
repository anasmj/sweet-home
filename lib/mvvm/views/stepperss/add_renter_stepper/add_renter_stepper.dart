import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/views/stepperss/add_renter_stepper/steps_pages/first_step.dart';
import 'package:sweet_home/mvvm/views/stepperss/add_renter_stepper/steps_pages/second_step.dart';
import 'package:sweet_home/mvvm/views/stepperss/add_renter_stepper/steps_pages/third_step.dart';
import '../../../providers/current_home.dart';
import '../../../view_models/add_renter_view_model.dart';
import '../../app_widgets.dart';
import '../../successful_pages/renter_add_successful.dart';
import '../../../../prev/view/screens/waiting_pages/adding_renter_indicator.dart';
import 'steps_pages/components/nav_buttons.dart';

class AddRenterStepper extends StatefulWidget {
  const AddRenterStepper({super.key});
  @override
  State<AddRenterStepper> createState() => _AddAddRenterStepperState();
}

class _AddAddRenterStepperState extends State<AddRenterStepper> {
  int _currentStep = 0;
  bool isCompletedd = false;
  bool isLoading = false;
  // int? nIdNumber;
  double? advanceAmount;

  @override
  Widget build(BuildContext context) {
    String homeId = Provider.of<CurrentHomeProvider>(context, listen: false)
        .currentHome!
        .homeId;
    final viewModel = Provider.of<AddRenterViewModel>(context);
    final bool isLastStep = getSteps().length - 1 == _currentStep;

    return Scaffold(
      appBar: AppBar(
        title: const Text('গ্রাহক যুক্ত করুন'),
        centerTitle: true,
        automaticallyImplyLeading: _currentStep != 0
            ? false
            : true, //disable back button when user not in first pag
      ),
      body: !isCompletedd
          ? isLoading
              ? const AddingRenterIndicator()
              : Stepper(
                  type: StepperType.horizontal,
                  currentStep: _currentStep,
                  onStepContinue: () async {
                    if (isLastStep) {
                      setState(() => isLoading = true);
                      await viewModel.addRenter(homeId: homeId);
                      if (viewModel.status == DataStatus.completed) {
                        setState(() => isCompletedd = true);
                      }
                      if (viewModel.status == DataStatus.error) {
                        AppWidget.showSnackBarWithMsg(
                            msg: 'দুঃক্ষিত, একটু পরে আবার চেষ্টা করুন');
                        setState(() => isLoading = false);
                      }
                    } else {
                      if (viewModel.firstPageFormKey!.currentState!
                          .validate()) {
                        setState(() => _currentStep += 1);
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
                    padding: const EdgeInsets.only(top: 80.0),
                    child: getNavButtons(details, context, isLastStep),
                  ),
                )
          //user added a new renter into the flat.
          : const AddRenterSuccessfulPage(),
    );
  }

  Row getNavButtons(
      ControlsDetails details, BuildContext context, bool isLastStep) {
    return Row(
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
          title: const Text('পেমেন্ট'),
          content: ThirdStepPage(),
        ),
      ];
}
