import 'package:flutter/material.dart';
import 'package:rent_home/utils/bills.dart';

import '../../../../models/month_details.dart';
import '../../../../models/renter.dart';
import '../../../../models/year.dart';

class ElectricityTable extends StatelessWidget {
  ElectricityTable({required this.renter, super.key});
  Renter renter;

  @override
  Widget build(BuildContext context) {
    Year currentYear =
        renter.records[renter.records.length - 1]; //last element of List<year>
    MonthDetails currentMonth =
        currentYear.months[currentYear.months.length - 1];
    MonthDetails previousMonth =
        currentYear.months[currentYear.months.length - 2];

    double usedUnit = double.parse((currentMonth.readingOfElecctricMeter -
            previousMonth.readingOfElecctricMeter)
        .toStringAsFixed(1));

    double electricBill = Bill.ElectricBill(
      currentMonth: currentMonth,
      previousMonth: previousMonth,
      electricUnitPrice: currentMonth.electricityUnitPrice!,
    ).calculateElectricBill(); //this method is written in 'Bill' class

    // print(electricBill.toString());
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("পূর্বের ইউনিট"),
              Text(
                previousMonth.readingOfElecctricMeter.toStringAsFixed(1),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("বর্তমান ইউনিট"),
              Text(currentMonth.readingOfElecctricMeter.toStringAsFixed(1)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("মোট ব্যাবহৃত ইউনিট"),
              Text(usedUnit.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "মোট মূল্য ($usedUnit * ${currentMonth.electricityUnitPrice!})"),
              Text(electricBill.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
