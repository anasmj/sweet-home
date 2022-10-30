import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/view_models/renter_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/components/shared_widgets.dart';

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
      return const Text('❌ কোনও একটি সমস্যা হয়েছে');
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
              flat.currentMeterReading != null
                  ? Text(Formatter.toBn(
                      value: flat.currentMeterReading, includeSymbol: false))
                  : const SizedBox(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('পূর্বের ইউনিট'),
              Text(
                Formatter.toBn(
                    value: flat.previousMeterReading ?? 0.00,
                    includeSymbol: false),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("ব্যাবহৃত ইউনিট"),
              Text(Formatter.toBn(
                  value: viewModel.usedUnit, includeSymbol: false)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '${Formatter.toBn(value: viewModel.usedUnit, includeSymbol: false)} x ${Formatter.toBn(value: viewModel.unitPrice, includeSymbol: false)} '),
              Text(Formatter.toBn(value: viewModel.electricBill)),
            ],
          )
        ],
      ),
    );
  }
  //*PREFER NOT TO USE STREAM
  // @override
  // Widget builda(BuildContext context) {
  //   RenterViewModel viewModel = context.watch<RenterViewModel>();
  //   String? flatId =
  //       context.watch<SelectedFlatProvider>().selectedFlat?.flatName;
  //   String? homeId = context.watch<CurrentHomeProvider>().currentHome?.homeId;

  //   if (flatId == null && homeId == null) return const SizedBox.shrink();

  //   return StreamBuilder<Flat>(
  //     stream:
  //         FlatService().selectedFlatSteram(homeId: homeId!, flatId: flatId!),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         Flat? flat = snapshot.data;

  //         if (flat == null) return const SizedBox.shrink();
  //         double? presentReading = flat.currentMeterReading;
  //         double? previousReading = flat.previousMeterReading;
  //         double usedUnit = 0.00;
  //         if (presentReading != null && previousReading != null) {
  //           usedUnit = presentReading - previousReading;
  //         }

  //         return SizedBox(
  //           width: 200,
  //           child: Column(
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text('বর্তমান ইউনিট'),
  //                   presentReading != null
  //                       ? Text(Formatter.toBn(
  //                           value: presentReading, includeSymbol: false))
  //                       : const SizedBox(),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text('পূর্বের ইউনিট'),
  //                   Text(
  //                     Formatter.toBn(
  //                         value: previousReading ?? 0.00, includeSymbol: false),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text("ব্যাবহৃত ইউনিট"),
  //                   Text(Formatter.toBn(value: usedUnit, includeSymbol: false)),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                       '${Formatter.toBn(value: usedUnit, includeSymbol: false)} x ${Formatter.toBn(value: viewModel.kUnitPrice, includeSymbol: false)} '),
  //                   Text(
  //                       Formatter.toBn(value: usedUnit * viewModel.kUnitPrice)),
  //                 ],
  //               )
  //             ],
  //           ),
  //         );
  //       } else {
  //         return const SizedBox();
  //       }
  //     },
  //   );
  // }
}
