import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/view_models/home_service_charge_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/confirm_calculation_button.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity/electricity_table.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/divider.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/due_row.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity/electricity_row.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/grand_total_row.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/total_bill_row.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/utility_bill_table/utility_bill_table.dart';
import 'general/general_bill_rows.dart';
import 'general/utility_row.dart';

// ignore: must_be_immutable
class MonthlyExpenceTable extends StatefulWidget {
  const MonthlyExpenceTable({super.key});

  @override
  State<MonthlyExpenceTable> createState() => _MonthlyExpenceTableState();
}

class _MonthlyExpenceTableState extends State<MonthlyExpenceTable> {
  get home => null;
  final double _fontSize = 16;
  bool canUpdate = true;

  @override
  Widget build(BuildContext context) {
    Flat? flat = Provider.of<FlatViewModel>(context).selectedFlat;
    if (flat == null) {
      return const SizedBox.shrink();
    }
    HomeServiceChargeListViewModel utilityListViewModel =
        context.watch<HomeServiceChargeListViewModel>();
    if (flat.confirmDate != null) {
      //present month expences already confirmed
      String confirmedDate = Formatter().makeId(date: flat.confirmDate!);
      String presentDate = Formatter().makeId(date: DateTime.now());
      if (confirmedDate == presentDate) {
        canUpdate = false;
      }
    }

    TextTheme textTheme = Theme.of(context).textTheme;

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
          UtilityRow(viewModel: context.watch<FlatViewModel>()),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: UtilityTable(viewModel: utilityListViewModel),
          ),
          transactionDivider,
          TotaBilllRow(textTheme: textTheme),
          DueRow(textTheme: textTheme),
          transactionDivider,
          GrandTotalRow(textTheme: textTheme),
          Visibility(
            visible: canUpdate,
            child: const Padding(
              padding: EdgeInsets.only(top: 10.0),
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
