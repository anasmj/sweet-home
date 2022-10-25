import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/home_stepper_provider.dart';

// ignore: must_be_immutable
class FlatFloorCounter extends StatelessWidget {
  FlatFloorCounter({
    this.isFlatCounter = false,
    Key? key,
  }) : super(key: key);

  bool isFlatCounter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 22,
              onPressed: () {
                isFlatCounter
                    ? context.read<HomeStepperProvider>().decreaseFlat()
                    : context.read<HomeStepperProvider>().decreaseFloor();
              },
              icon: const Icon(
                Icons.remove,
              ),
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                isFlatCounter
                    ? context.watch<HomeStepperProvider>().flatLength.toString()
                    : context
                        .watch<HomeStepperProvider>()
                        .floorLength
                        .toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              iconSize: 22,
              onPressed: () {
                isFlatCounter
                    ? context.read<HomeStepperProvider>().increaseFlat()
                    : context.read<HomeStepperProvider>().increaseFloor();
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        Text(
          isFlatCounter ? 'প্রতি তলায়\nফ্ল্যাট সংখ্যা' : 'তলা',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
