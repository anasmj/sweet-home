import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/view_models/home_service_charge_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/components/confirm_calculation_button.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity/electricity_table.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity/electricity_row.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/utility_bill_table/utility_bill_table.dart';
import 'components/table_rows.dart';
import 'components/table_widgets.dart';
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
  Widget transactionDivider = Divider(
    thickness: 2,
    color: Colors.black.withOpacity(0.6),
  );

  @override
  Widget build(BuildContext context) {
    FlatViewModel? viewModel = Provider.of<FlatViewModel>(context);
    Flat? flat = Provider.of<FlatViewModel>(context).selectedFlat;
    if (flat == null) {
      return const SizedBox.shrink();
    }
    double? prevReading = flat.previousMeterReading;
    double? presentReading = flat.presentMeterReading;
    bool showAlert = prevReading == null || presentReading == null;

    HomeServiceChargeListViewModel utilityListViewModel =
        context.watch<HomeServiceChargeListViewModel>();
    if (flat.confirmDate != null) {
      //present month expences already confirmed
    }

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
            showAlert: showAlert,
            prevReading: prevReading,
            presentReading: presentReading,
            bill: viewModel.isLoading
                ? ''
                : Formatter.toBn(value: viewModel.electricBill ?? 0),
            fontSize: _fontSize,
          ),

          // ElectricityRow(
          //   fontSize: _fontSize,
          // ),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: viewModel.isLoading
                ? billLoadingIndocator
                : viewModel.userFlat == null
                    ? const Text('❌')
                    : ElectricityTable(
                        presentReading: presentReading,
                        prevReading: prevReading,
                        usedUnit: viewModel.usedUnit,
                        bill: viewModel.electricBill,
                        unitPrice: viewModel.unitPrice,
                      ),
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
          const RecievedRow(),
          const MonthlyDueRow(),
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
