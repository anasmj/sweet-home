import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/home_stepper_view_model.dart';

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
                    ? context
                        .read<HomeStepperProviderViewModel>()
                        .decreaseFlat()
                    : context
                        .read<HomeStepperProviderViewModel>()
                        .decreaseFloor();
              },
              icon: const Icon(
                Icons.remove,
              ),
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                isFlatCounter
                    ? context
                        .watch<HomeStepperProviderViewModel>()
                        .flatLength
                        .toString()
                    : context
                        .watch<HomeStepperProviderViewModel>()
                        .floorLength
                        .toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              iconSize: 22,
              onPressed: () {
                isFlatCounter
                    ? context
                        .read<HomeStepperProviderViewModel>()
                        .increaseFlat()
                    : context
                        .read<HomeStepperProviderViewModel>()
                        .increaseFloor();
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
