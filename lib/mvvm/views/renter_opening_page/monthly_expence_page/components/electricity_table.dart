import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/bills_provider.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';

// ignore: must_be_immutable
class ElectricityTable extends StatelessWidget {
  const ElectricityTable({super.key});

  @override
  Widget build(BuildContext context) {
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
                  ? Text(Formatter.toBn(
                      value: billsProvider.currentReading,
                      includeSymbol: false))
                  : const SizedBox(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('পূর্বের ইউনিট'),
              Text(
                Formatter.toBn(
                    value: billsProvider.previousReading, includeSymbol: false),
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
                            Formatter.toBn(
                                value: billsProvider.usedUnit,
                                includeSymbol: false),
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
                            '${Formatter.toBn(value: billsProvider.usedUnit, includeSymbol: false)} x ${Formatter.toBn(value: billsProvider.CONST_FACTOR, includeSymbol: false)} '
                            // '${billsProvider.usedUnit} x ${billsProvider.CONST_FACTOR}',
                            ),
                        Text(Formatter.toBn(value: billsProvider.electricBill)),
                        // '৳ ${billsProvider.electricBill.toStringAsFixed(1)}'),
                      ],
                    )
              : const SizedBox(),
        ],
      ),
    );
  }
}
