import 'package:flutter/material.dart';
import 'package:sweet_home/src/utils/formatter.dart';

// ignore: must_be_immutable
class ElectricityTable extends StatelessWidget {
  ElectricityTable({
    super.key,
    this.presentReading,
    this.prevReading,
    this.usedUnit,
    this.bill,
    required this.unitPrice,
  });
  double? prevReading, presentReading, usedUnit, bill;
  double unitPrice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('পূর্বের ইউনিট'),
              Text(prevReading != null
                  ? Formatter.toBn(value: prevReading, includeSymbol: false)
                  : '-')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('বর্তমান ইউনিট'),
              Text(presentReading != null
                  ? Formatter.toBn(value: presentReading, includeSymbol: false)
                  : '-')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('ব্যাবহৃত ইউনিট'),
              Text(usedUnit != null
                  ? Formatter.toBn(value: usedUnit, includeSymbol: false)
                  : '-')
            ],
          ),
          usedUnit != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${Formatter.toBn(value: usedUnit, includeSymbol: false)} x ${Formatter.toBn(value: unitPrice, includeSymbol: false)} '),
                    Text(
                      Formatter.toBn(value: bill ?? 0.00, includeSymbol: false),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
