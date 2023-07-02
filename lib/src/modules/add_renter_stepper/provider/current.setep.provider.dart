import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/providers/form.key.provider.dart';

import '../view/steps_pages/first_step.dart';
import '../view/steps_pages/second_step.dart';
import '../view/steps_pages/third_step.dart';

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

  void onStepContinue() async {
    final bool isLastStep = steps.length - 1 == state;

    if (isLastStep) {
      isLoading = true;
      ref.notifyListeners();
      await Future.delayed(const Duration(seconds: 2));
      isLoading = false;
      hasError = true;
      ref.notifyListeners();

      // final renter = ref.read(newRenterProvider);
      // RenterTransaction? transaction;
      // if (ref.read(newRenterProvider.notifier).includeAdvance) {
      //   transaction = RenterTransaction(
      //     paidBy: ref.read(newRenterProvider.notifier).advance ?? '',
      //     amount:
      //         int.parse(ref.read(newRenterProvider.notifier).advance ?? '0'),
      //     time: renter.entryDate ?? DateTime.now(),
      //     isAdvance: true,
      //   );
      // }
      // final transactionRes = await TransactionService().addTransactionToFlat(
      //   homeId: ref.watch(selectedHomeProvider)!.homeId!,
      //   flatId: ref.watch(selectedFlatNotifier)!.flatName,
      //   transaction: transaction!,
      // );
      // if (transactionRes.code != 200) {
      //   return;
      // }
      // final res = await RenterService().addRenterToFlat(
      //   homeId: ref.watch(selectedHomeProvider)!.homeId!,
      //   renter: renter,
      //   flatId: ref.watch(selectedFlatNotifier)!.flatName,
      //   renterTransaction: transaction,
      // );

      return;
    }
    if (state == 0) {
      final formState =
          ref.read(formKeyProvider(FormKey.renterFirstPage)).currentState;
      if (formState == null || !formState.validate()) return;
    }
    state = state + 1;
  }

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
