import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/new_home_step_provider.dart';

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
                    ? context.read<NewHomeStepProvider>().decreaseFlat()
                    : context.read<NewHomeStepProvider>().decreaseFloor();
              },
              icon: Icon(
                Icons.remove,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                isFlatCounter
                    ? context.watch<NewHomeStepProvider>().flatLength.toString()
                    : context
                        .read<NewHomeStepProvider>()
                        .floorLength
                        .toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            IconButton(
              iconSize: 22,
              onPressed: () {
                isFlatCounter
                    ? context.read<NewHomeStepProvider>().increaseFlat()
                    : context.read<NewHomeStepProvider>().increaseFloor();
              },
              icon: Icon(
                Icons.add,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
        Text(
          isFlatCounter ? 'প্রতি তলায়\nফ্ল্যাট সংখ্যা' : 'তলা',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
