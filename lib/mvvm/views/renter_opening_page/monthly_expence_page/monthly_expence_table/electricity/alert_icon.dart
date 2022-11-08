import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity/meter_reading_dialog.dart';

// ignore: must_be_immutable
class AlertIcon extends StatelessWidget {
  AlertIcon({super.key, required this.unitType});

  UnitType unitType;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showElectricityUnitDialog(context: context, unitType: unitType);
      },
      icon: const Icon(
        Icons.info_outline,
        size: 16,
        color: Colors.red,
      ),
    );
  }
}
