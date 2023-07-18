import 'package:flutter/material.dart';
import 'package:sweet_home/src/utils/formatter.dart';

import 'components/table_rows.dart';
import 'electricity/electricity_row.dart';
import 'electricity/electricity_table.dart';
import 'general/general_bill_rows.dart';
import 'general/utility_row.dart';
import 'utility_bill_table/utility_bill_table.dart';

// ignore: must_be_immutable
class RecordExpenceTable extends StatelessWidget {
  RecordExpenceTable({super.key, required this.record});
  Record record;
  Widget transactionDivider = Divider(
    thickness: 2,
    color: Colors.black.withOpacity(0.6),
  );
  double _usedUnit = 0;

  @override
  Widget build(BuildContext context) {
    double monthlyDue = 0;
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          flatRentRow(Formatter.toBn(value: 3)),
          // flatRentRow(flat),
          gasBillRow(Formatter.toBn(value: 2)),
          waterBillRow(Formatter.toBn(value: 2)),
          ElectricityBillRow(
            prevReading: 2,
            presentReading: 2,
            bill: Formatter.toBn(value: 0),
            // showAlert: false,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: ElectricityTable(
              presentReading: 2,
              prevReading: 2,
              usedUnit: _usedUnit,
              bill: 2,
              unitPrice: 2,
            ),
          ),
          const UtilityRow(),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: UtilityTable(
              utilityList: const [],
            ),
          ),
          transactionDivider,
          TotaBilllRow(textTheme: textTheme),

          DueRow(textTheme: textTheme),
          transactionDivider,
          GrandTotalRow(textTheme: textTheme),
          RecievedRow(amount: 43),
          transactionDivider,
          MonthlyDueRow(amount: monthlyDue),
          const SizedBox(
            height: 10,
          ),
        ]
            .map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: e))
            .toList(),
      ),
    );
  }
}
