import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/record.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/expence_table/electricity/electricity_table.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/expence_table/electricity/electricity_row.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/expence_table/utility_bill_table/utility_bill_table.dart';
import 'components/table_rows.dart';
import 'general/general_bill_rows.dart';
import 'general/utility_row.dart';

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
    if (record.presentMeterReading != null &&
        record.previousMeterReading != null) {
      _usedUnit = record.presentMeterReading! - record.previousMeterReading!;
    }
    double monthlyDue = 0;
    TextTheme textTheme = Theme.of(context).textTheme;
    if (record.paid != null && record.grandTotal != null) {
      monthlyDue = record.grandTotal! - record.paid!;
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          flatRentRow(Formatter.toBn(value: record.flatRent)),
          // flatRentRow(flat),
          gasBillRow(Formatter.toBn(value: record.gasBill)),
          waterBillRow(Formatter.toBn(value: record.waterBill)),
          ElectricityBillRow(
            prevReading: record.previousMeterReading,
            presentReading: record.presentMeterReading,
            bill: Formatter.toBn(value: record.electricBill ?? 0),
            // showAlert: false,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: ElectricityTable(
              presentReading: record.presentMeterReading,
              prevReading: record.previousMeterReading,
              usedUnit: _usedUnit,
              bill: record.electricBill,
              unitPrice: record.unitPrice ?? 1,
            ),
          ),
          UtilityRow(viewModel: context.watch<FlatViewModel>()),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: UtilityTable(
              utilityList: record.utilities ?? [],
            ),
          ),
          transactionDivider,
          TotaBilllRow(textTheme: textTheme),

          DueRow(textTheme: textTheme),
          transactionDivider,
          GrandTotalRow(textTheme: textTheme),
          RecievedRow(amount: record.paid),
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
