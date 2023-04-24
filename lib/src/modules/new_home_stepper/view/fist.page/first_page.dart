import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/new_home_stepper/provider/new.home.provider.dart';
import 'package:sweet_home/src/modules/new_home_stepper/provider/stepper.provider.dart';
import '../../components/counter.dart';

class FristPage extends ConsumerWidget {
  const FristPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final provider = Provider.of<HomeStepperProviderViewModel>(context);
    // provider.firstPageFormKey = _firstPageFormKey;
    return Form(
      // key: provider.firstPageFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(hintText: 'বাড়ীর নাম'),
            onChanged: ref.read(newHomeNotifier.notifier).onHomeNameChange,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'ঠিকানা'),
            onChanged: ref.read(newHomeNotifier.notifier).onHomeAddressChange,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatFloorCounter(
                titleText: 'floor',
                number: ref.watch(newHomeNotifier).floor,
                onAdd: ref.read(newHomeNotifier.notifier).addFloor,
                onDelete: ref.read(newHomeNotifier.notifier).deleteFloor,
              ),
              FlatFloorCounter(
                titleText: 'flat per floor',
                number: ref.watch(newHomeNotifier).flatPerFloor,
                onAdd: ref.read(newHomeNotifier.notifier).addFlat,
                onDelete: ref.read(newHomeNotifier.notifier).deleteFlat,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
