import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/modules/flats/provider/selected.flat.provider.dart';
import 'package:sweet_home/src/utils/formatter.dart';

import 'components/confirm_calculation_button.dart';
import 'components/table_rows.dart';
import 'components/table_widgets.dart';
import 'electricity/electricity_row.dart';
import 'electricity/electricity_table.dart';
import 'general/general_bill_rows.dart';
import 'general/utility_row.dart';
import 'utility_bill_table/utility_bill_table.dart';

// ignore: must_be_immutable
class ConfirmExpenceTable extends ConsumerWidget {
  ConfirmExpenceTable({super.key});

  get home => null;
  Widget transactionDivider = Divider(
    thickness: 2,
    color: Colors.black.withOpacity(0.6),
  );

  @override
  Widget build(BuildContext context, ref) {
    Flat? flat = ref.watch(selectedFlatProvider);
    if (flat == null) {
      return const SizedBox.shrink();
    }
    double? prevReading = flat.previousMeterReading;
    double? presentReading = flat.presentMeterReading;
    // bool showAlert = prevReading == null || presentReading == null;

    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          flatRentRow(Formatter.toBn(value: flat.flatRentAmount)),
          // flatRentRow(flat),
          gasBillRow(Formatter.toBn(value: flat.flatGasBill)),
          waterBillRow(Formatter.toBn(value: flat.flatWaterBill)),
          ElectricityBillRow(
            // showAlert: showAlert,
            prevReading: prevReading,
            presentReading: presentReading,
            bill: Formatter.toBn(value: 0),
          ),

          // ElectricityRow(
          //   fontSize: _fontSize,
          // ),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: false
                ? tableCircularIndicator
                : false
                    ? const Text('❌')
                    : ElectricityTable(
                        presentReading: presentReading,
                        prevReading: prevReading,
                        usedUnit: 787.90,
                        bill: 787.90,
                        unitPrice: 787.90,
                      ),
          ),
          const UtilityRow(),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child:
                false ? tableCircularIndicator : UtilityTable(utilityList: []),
          ),
          transactionDivider,
          TotaBilllRow(textTheme: textTheme),

          DueRow(textTheme: textTheme),
          transactionDivider,
          GrandTotalRow(textTheme: textTheme),
          // const RecievedRow(),
          // const MonthlyDueRow(),

          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: ConfirmCalculationButton(),
            ),
          ),
          const SizedBox(
            height: 70,
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
