import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/counter.dart';
import '../../provider/new.home.provider.dart';

class FristPage extends ConsumerWidget {
  const FristPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(hintText: 'বাড়ীর নাম'),
            onChanged: ref.read(newHomeProvider.notifier).onHomeNameChange,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'ঠিকানা'),
            onChanged: ref.read(newHomeProvider.notifier).onHomeAddressChange,
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
                number: ref.watch(newHomeProvider).floor,
                onAdd: ref.read(newHomeProvider.notifier).addFloor,
                onDelete: ref.read(newHomeProvider.notifier).deleteFloor,
              ),
              FlatFloorCounter(
                titleText: 'flat per floor',
                number: ref.watch(newHomeProvider).flatPerFloor,
                onAdd: ref.read(newHomeProvider.notifier).addFlat,
                onDelete: ref.read(newHomeProvider.notifier).deleteFlat,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
