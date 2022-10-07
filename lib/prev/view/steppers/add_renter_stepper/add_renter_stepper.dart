import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';

import 'package:provider/provider.dart';
import 'package:sweet_home/prev/view/steppers/add_renter_stepper/steps_pages/first_step.dart';
import 'package:sweet_home/prev/view/steppers/add_renter_stepper/steps_pages/second_step.dart';
import 'package:sweet_home/prev/view/steppers/add_renter_stepper/steps_pages/third_step.dart';
import '../../../../mvvm/models/response.dart';
import '../../../../mvvm/providers/current_home.dart';
import '../../../../mvvm/providers/selected_flat_provider.dart';
import '../../../../mvvm/repositories/renter_service.dart';
import '../../../providers/newrenter_step_provider.dart';
import '../../../../mvvm/repositories/flat_services.dart';

import '../../../../mvvm/views/app_widgets.dart';
import '../../../../mvvm/views/successful_pages/renter_add_successful.dart';
import '../../screens/waiting_pages/addingRenterIndicator.dart';

class AddRenterStepper extends StatefulWidget {
  const AddRenterStepper({super.key});
  @override
  State<AddRenterStepper> createState() => _AddAddRenterStepperState();
}

class _AddAddRenterStepperState extends State<AddRenterStepper> {
  int _currentStep = 0;
  bool isCompletedd = false;
  bool isLoading = false;
  // bool isValidInfo = false;
  // Future<Response> addRenterToDatabase(BuildContext context) async {
  //   final provider = Provider.of<NewRenterStepProvider>(context, listen: false);
  //   final flat = context.read<SelectedFlatProvider>().selectedFlat;
  //   String homeId = Provider.of<CurrentHomeProvider>(context, listen: false)
  //       .currentHome!
  //       .homeId;
  //   double advanceAmount = provider.advanceController.text.isNotEmpty
  //       ? double.parse(provider.advanceController.text)
  //       : 0.00;
  //   Response response = await RenterService().addRenterToFlat(
  //     homeId: homeId,
  //     flatId: flat!.flatName,
  //     renterName: provider.renterNameController.text,
  //     phoneNo: provider.phoneController.text,
  //     alternatePhoneNo: provider.altPhoneController.text,
  //     occupation: provider.occupation,
  //     noOfPerson: provider.memberNo,
  //     entryDate: DateTime.now(),
  //     previousLocation: provider.previousLocationController.text,
  //     village: provider.villageController.text,
  //     policeStation: provider.thanaController.text,
  //     union: provider.unionController.text,
  //     subDistrict: provider.subDistrictController.text,
  //     district: provider.districtController.text,
  //     advance: advanceAmount,
  //   );

  //   return response;
  // }

  int? nIdNumber;
  double? advanceAmount;

  @override
  Widget build(BuildContext context) {
    String homeId = Provider.of<CurrentHomeProvider>(context, listen: false)
        .currentHome!
        .homeId;
    final provider = Provider.of<NewRenterStepProvider>(context);

    //used to validate state of form
    final flat = context.read<SelectedFlatProvider>().selectedFlat;
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
                      setState(() {
                        isLoading = true;
                        // isCompletedd = true;
                        // clearPreviousRenterInfo(context);
                      });
                      advanceAmount = provider.advanceController.text.isNotEmpty
                          ? double.parse(provider.advanceController.text)
                          : 0.00;
                      nIdNumber = provider.nIdController.text.isNotEmpty
                          ? int.parse(provider.nIdController.text)
                          : null;

                      Response res = await RenterService().addRenterToFlat(
                        homeId: homeId,
                        flatId: flat!.flatName,
                        renterName: provider.renterNameController.text,
                        phoneNo: provider.phoneController.text,
                        alternatePhoneNo: provider.altPhoneController.text,
                        occupation: provider.occupation,
                        noOfPerson: provider.memberNo,
                        entryDate: provider.entryDate,
                        previousLocation:
                            provider.previousLocationController.text,
                        village: provider.villageController.text,
                        policeStation: provider.thanaController.text,
                        union: provider.unionController.text,
                        subDistrict: provider.subDistrictController.text,
                        nIdNumber: nIdNumber,
                        district: provider.districtController.text,
                        advance: advanceAmount,
                      );

                      // success
                      if (res.code == 200) {
                        // ignore: use_build_context_synchronously
                        Provider.of<FlatListViewModel>(context)
                            .configureFltas(homeId);
                        provider.renterNameController.clear();
                        provider.phoneController.clear();
                        provider.altPhoneController.clear();
                        provider.setOccupation('');
                        provider.setMemberNo = 1;
                        provider.setEntryDate = DateTime.now();

                        provider.previousLocationController.clear();
                        provider.villageController.clear();
                        provider.thanaController.clear();
                        provider.unionController.clear();
                        provider.subDistrictController.clear();
                        provider.districtController.clear();
                        setState(() {
                          isLoading = false;

                          advanceAmount = 0;
                          isCompletedd = true;
                        });

                        //failed
                      } else {
                        AppWidget.snackBarContent(
                            msg: res.body ??
                                'যুক্ত করা সম্ভব হয়নি, আবার চেষ্টা করুন');
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      if (provider.firstPageFormKey!.currentState!.validate()) {
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

  void clearPreviousRenterInfo(BuildContext context) {
    final provider = Provider.of<NewRenterStepProvider>(context, listen: false);
    provider.advanceController.clear();
    provider.renterNameController.clear();
    provider.setMemberNo = 1;
    provider.altPhoneController.clear();
    provider.phoneController.clear();
    provider.previousLocationController.clear();
    provider.thanaController.clear();
    provider.unionController.clear();
    provider.subDistrictController.clear();
    provider.districtController.clear();
    provider.villageController.clear();
  }

  Row getNavButtons(
      ControlsDetails details, BuildContext context, bool isLastStep) {
    return Row(
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
            isLastStep: isLastStep,
          ),
        ),
      ],
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

  OutlinedButton backNavigationButton(ControlsDetails details) {
    bool isDark = context.watch<ThemeProvider>().isDarkMode;

    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: isDark ? Colors.grey.shade400 : Colors.blue,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // backgroundColor: Colors.grey,
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
          title: const Text('পেমেন্ট'),
          content: ThirdStepPage(),
        ),
      ];
}
