import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/flat_model.dart';
import '../../../../../models/renter.dart';
import '../../../../../providers/bills_provider.dart';

// ignore: must_be_immutable
class ElectricityTable extends StatelessWidget {
  ElectricityTable({super.key});
  final double _fontSize = 14;
  @override
  Widget build(BuildContext context) {
    double? usedUnit;
    BillsProvider billsProvider = Provider.of<BillsProvider>(context);
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('বর্তমান ইউনিট'),
              billsProvider.currentReading != null
                  ? Text(
                      billsProvider.currentReading.toString(),
                    )
                  : const SizedBox(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('পূর্বের ইউনিট'),
              Text(
                billsProvider.previousReading.toString(),
              ),
            ],
          ),
          billsProvider.totalBill == null
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("ব্যাবহৃত ইউনিট"),
                    billsProvider.currentReading != null
                        ? Text(
                            billsProvider.usedUnit.toString(),
                          )
                        : const SizedBox(),
                  ],
                ),
          billsProvider.currentReading != null
              ? billsProvider.totalBill == null
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${billsProvider.usedUnit} x ${billsProvider.CONST_FACTOR}'),
                        Text(
                            '৳ ${billsProvider.electricBill.toStringAsFixed(1)}'),
                      ],
                    )
              : const SizedBox(),
        ],
      ),
    );
  }
}
