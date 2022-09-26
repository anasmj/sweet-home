import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import '../../../../../models/flat_model.dart';
import '../../../../../models/renter.dart';

// ignore: must_be_immutable
class ElectricityTable extends StatelessWidget {
  ElectricityTable({super.key});
  double? usedUnit;
  double? totalCost;
  @override
  Widget build(BuildContext context) {
    Flat? flat = context.watch<SelectedFlatProvider>().selectedFlat;
    double? currentUnit = flat!.currentMeterReading;
    double? previousUnit = flat.previousMeterReading;

    double CONST_FACTOR = 0.7;

    if (currentUnit != null && previousUnit != null) {
      usedUnit = (currentUnit - previousUnit);
      if (usedUnit != null) totalCost = usedUnit! * CONST_FACTOR;
    }
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('বর্তমান ইউনিট'),
              Text(
                currentUnit != null ? currentUnit.toString() : '',
                // CalculateBill.setRenter(renter: renter).previousMonthReading,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('পূর্বের ইউনিট'),
              Text(
                previousUnit != null ? previousUnit.toString() : '-',
                // CalculateBill.setRenter(renter: renter).currentMonthReading,
              ),
            ],
          ),
          totalCost == null
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("ব্যাবহৃত ইউনিট"),
                    Text(
                      usedUnit != null ? usedUnit.toString() : '',
                    ),
                  ],
                ),
          totalCost == null
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$usedUnit x 0.8'),
                    // Text('0.7'),
                    // Text(electricBill.toString()),
                    Text('৳ $totalCost')
                  ],
                ),
        ],
      ),
    );
  }
}
