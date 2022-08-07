import 'package:flutter/material.dart';

class ElectricityTable extends StatelessWidget {
  const ElectricityTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FractionColumnWidth(0.32),
        1: FractionColumnWidth(0.12)
      },
      children: [
        buildRow(
          ['বর্তমান ইউনিট', '2923'],
        ),
        buildRow(['পূর্বের ইউনিট', '2354']),
        buildRow(['মোট ব্যাবহৃত ইউনিট', '234']),
        buildRow(['মোট মূল্য', '1245']),
      ],
    );
  }

  TableRow buildRow(
    List<String> cells,
  ) =>
      TableRow(
        children: cells.map((e) {
          return Text(e);
        }).toList(),
      );
}
