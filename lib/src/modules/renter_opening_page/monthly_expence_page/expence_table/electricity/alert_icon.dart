import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/constants/constants.dart';

import 'meter_reading_dialog.dart';

class AlertIcon extends ConsumerWidget {
  const AlertIcon({super.key, required this.unitType});

  final UnitType unitType;
  @override
  Widget build(BuildContext context, ref) {
    return IconButton(
      onPressed: () async {
        await showElectricityUnitDialog(
          context: context,
          unitType: unitType,
          ref: ref,
        );
      },
      icon: const Icon(
        Icons.info_outline,
        size: 16,
        color: Colors.red,
      ),
    );
  }
}
