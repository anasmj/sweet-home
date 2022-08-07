import 'package:flutter/material.dart';

class OthersTable extends StatelessWidget {
  const OthersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FractionColumnWidth(0.2),
        1: FractionColumnWidth(0.12)
      },
      children: [
        buildRow(
          ['ময়লা', '1oo'],
        ),
        buildRow(['সিঁড়ি মোছা', '125']),
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
