import 'package:flutter/material.dart';
import '../../../../../models/renter.dart';

// ignore: must_be_immutable
class ElectricityTable extends StatelessWidget {
  ElectricityTable({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: keep it to the kitchen
    //! this is for demo purpose, it can be null in real scenario if not changed
    // Year currentYear = renter
    //     .records![renter.records!.length - 1]; //last element of List<year>
    // MonthDetails currentMonth =
    //     currentYear.months[currentYear.months.length - 1];
    // MonthDetails previousMonth =
    //     currentYear.months[currentYear.months.length - 2];

    // double usedUnit = double.parse((currentMonth.readingOfElecctricMeter -
    //         previousMonth.readingOfElecctricMeter)
    //     .toStringAsFixed(1));

    // String electricBill = CalculateBill.setRenter(renter: renter)
    //     .getElectricBill; //returns current electeric bill

    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("আগের মাসের ইউনিট"),
              Text(
                '23423',
                // CalculateBill.setRenter(renter: renter).previousMonthReading,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("এ মাসের ইউনিট"),
              Text(
                '23432',
                // CalculateBill.setRenter(renter: renter).currentMonthReading,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("ব্যাবহৃত ইউনিট"),
              Text(
                '23432',

                // CalculateBill.setRenter(renter: renter).usedUnitOfElectricity,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("মূল্য ($usedUnit * ${currentMonth.electricityUnitPrice!})"),
              Text('0.7'),
              // Text(electricBill.toString()),
              Text('32333')
            ],
          ),
        ],
      ),
    );
  }
}
