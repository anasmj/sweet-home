import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/monthly_expence_table/electricity_table/bill_loading_indicator.dart';

// ignore: must_be_immutable
class ElectricityTable extends StatelessWidget {
  const ElectricityTable({super.key});

  @override
  Widget build(BuildContext context) {
    FlatViewModel viewModel = context.watch<FlatViewModel>();

    if (viewModel.isLoading) {
      return billLoadingIndocator;
    }
    if (viewModel.userFlat == null) {
      return const Text('❌');
    }

    Flat flat = viewModel.userFlat!;
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('বর্তমান ইউনিট'),
              Text(viewModel.userFlat?.presentMeterReading != null
                  ? Formatter.toBn(
                      value: flat.presentMeterReading, includeSymbol: false)
                  : '-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('পূর্বের ইউনিট'),
              Text(
                viewModel.userFlat?.previousMeterReading != null
                    ? Formatter.toBn(
                        value: flat.previousMeterReading ?? 0.00,
                        includeSymbol: false)
                    : '-',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("ব্যাবহৃত ইউনিট"),
              Text(viewModel.usedUnit != null
                  ? Formatter.toBn(
                      value: viewModel.usedUnit, includeSymbol: false)
                  : '-'),
            ],
          ),
          viewModel.usedUnit != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${Formatter.toBn(value: viewModel.usedUnit, includeSymbol: false)} x ${Formatter.toBn(value: viewModel.unitPrice, includeSymbol: false)} '),
                    Text(Formatter.toBn(value: viewModel.electricBill)),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
