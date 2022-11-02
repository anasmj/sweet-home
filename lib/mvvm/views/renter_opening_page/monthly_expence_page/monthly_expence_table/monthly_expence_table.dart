import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/components/confirm_calculation_button.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity_table/electricity_table.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/divider.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/due_row.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity_table/electricity_row.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/grand_total_row.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/total_bill_row.dart';
import 'general/general_bill_rows.dart';

// ignore: must_be_immutable
class MonthlyExpenceTable extends StatefulWidget {
  const MonthlyExpenceTable({super.key});

  @override
  State<MonthlyExpenceTable> createState() => _MonthlyExpenceTableState();
}

class _MonthlyExpenceTableState extends State<MonthlyExpenceTable> {
  get home => null;
  final double _fontSize = 16;

  @override
  Widget build(BuildContext context) {
    Flat? flat = Provider.of<SelectedFlatProvider>(context).selectedFlat;

    TextTheme textTheme = Theme.of(context).textTheme;
    if (flat == null) {
      return const SizedBox.shrink();
    } else {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            flatRentRow(flat),
            gasBillRow(flat),
            waterBillRow(flat),
            ElectricityRow(
              fontSize: _fontSize,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: ElectricityTable(),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     getPurposeTitle(titleIcon: AppIcons.otherUrl, title: 'অন্যান্য'),
            //     // Text(CalculateBill.setRenter(renter: renter).sumOfOtherBills)

            //     Text('৳ 3232'),
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 40.0),
            //   child: OthersTable(
            //     othersList: CalculateBill.setRenter(renter: renter)
            //         .otherExpenceListForThisMonth,
            //   ),
            // ),
            transactionDivider,
            TotaBilllRow(textTheme: textTheme),
            DueRow(textTheme: textTheme, account: flat.renter!.dueAmount),
            transactionDivider,
            GrandTotalRow(textTheme: textTheme),
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: ConfirmCalculationButton(),
                ),
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
}
