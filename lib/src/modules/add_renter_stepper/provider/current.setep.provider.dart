import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/api/flat_services.dart';
import 'package:sweet_home/src/api/renter_service.dart';
import 'package:sweet_home/src/components/error.page/error_page.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/extensions/extensions.dart';
import 'package:sweet_home/src/model/transaction.dart';
import 'package:sweet_home/src/modules/flats/provider/selected.flat.provider.dart';
import 'package:sweet_home/src/providers/form.key.provider.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart';

import '../components/renter_add_successful.dart';
import '../view/steps_pages/first_step.dart';
import '../view/steps_pages/second_step.dart';
import '../view/steps_pages/third_step.dart';
import 'new.renter.provider.dart';

final newRenterStepProvider = NotifierProvider<CurrentStepperProvider, int>(
  CurrentStepperProvider.new,
);

class CurrentStepperProvider extends Notifier<int> {
  bool isCompleted = false;
  bool isLoading = false;
  bool hasError = false;
  ControlsDetails? stepperDetails;
  @override
  int build() => 0;

  void setControllerDetail(ControlsDetails detail) => stepperDetails = detail;
  void reset() {
    isLoading = false;
    isCompleted = false;
    hasError = false;
  }

  void showError(BuildContext context) => context.pushReplacement(
        ErrorPage(onRetry: () => context.pop()),
      );

  void showSuccess(BuildContext context) =>
      context.pushReplacement(const AddRenterSuccessfulPage());

  Future<bool> addRenterToFlat() async {
    final res = await RenterService().addRenterToFlat(
      homeId: ref.watch(selectedHomeProvider)!.homeId!,
      renter: ref.read(newRenterProvider),
      flatId: ref.watch(selectedFlatProvider)!.flatName,
    );
    return res.code == 200;
  }

  Future<bool> addTransactionToFlat() async {
    final transaction = RenterTransaction(
      paidBy: ref.read(newRenterProvider).renterName ?? '',
      amount: int.parse(ref.read(newRenterProvider.notifier).advance ?? '0'),
      time: DateTime.now(),
      isAdvance: true,
      renter: ref.read(newRenterProvider),
    );
    return await FlatService().addTransactionToFlat(
      ref.watch(selectedHomeProvider)!.homeId!,
      ref.watch(selectedFlatProvider)!.flatName,
      transaction,
    );
  }

  void onStepContinue(BuildContext context) async {
    final bool isLastStep = steps.length - 1 == state;

    if (isLastStep) {
      isLoading = true;
      ref.notifyListeners();
      if (!ref.read(newRenterProvider.notifier).includeAdvance) {
        final isAdded = await addRenterToFlat();
        if (isAdded && context.mounted) {
          showSuccess(context);
        } else {
          showError(context);
        }
      } else {
        final isTransactionAdded = await addTransactionToFlat();
        if (isTransactionAdded && context.mounted) {
          bool isRenterAdded = await addRenterToFlat();
          if (isRenterAdded && context.mounted) {
            showSuccess(context);
          } else {
            showError(context);
          }
        } else {
          showError(context);
        }
      }
      isLoading = false;
      return;
    }
    if (state == 0) {
      final formState =
          ref.read(formKeyProvider(FormKey.renterFirstPage)).currentState;
      if (formState == null || !formState.validate()) return;
    }
    state = state + 1;
  }

  void addRenterWithoutTrasaction() {}
  void onStepCancel() {
    if (state == 0) return;
    state = state - 1;
  }

  List<Step> get steps => <Step>[
        Step(
          state: state > 0 ? StepState.complete : StepState.indexed,
          isActive: state >= 0,
          title: const Text('তথ্য'),
          content: const RenterInfoStep(),
        ),
        Step(
          state: state > 1 ? StepState.complete : StepState.indexed,
          isActive: state >= 1,
          title: const Text('ঠিকানা'),
          content: AddressStep(),
        ),
        Step(
          state: state > 2 ? StepState.complete : StepState.indexed,
          isActive: state >= 2,
          title: const Text('পেমেন্ট'),
          content: const ThirdStepPage(),
        ),
      ];
}
