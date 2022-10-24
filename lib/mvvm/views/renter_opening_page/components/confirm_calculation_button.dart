import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/transaction_provider.dart';
import 'package:sweet_home/mvvm/providers/bills_provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/record_services.dart';
import 'package:sweet_home/mvvm/view_models/renter_opening_page_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';

// ignore: must_be_immutable
class ConfirmCalculationButton extends StatelessWidget {
  ConfirmCalculationButton({
    required this.text,
    Key? key,
  }) : super(key: key);

  String text;
  @override
  Widget build(BuildContext context) {
    RenterOpeningViewModel providerWatch =
        context.watch<RenterOpeningViewModel>();

    String? homeId = context.watch<CurrentHomeProvider>().currentHome?.homeId;
    Flat? flat = context.watch<SelectedFlatProvider>().selectedFlat;
    TransactionProvider trasaction = context.watch<TransactionProvider>();
    DateTime issueDate = DateTime.now();

    // double? meterReading = context.watch<RenterOpeningViewModel>().meterReading;

    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      minWidth: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      color: Theme.of(context).secondaryHeaderColor,
      disabledColor: Colors.grey,
      onPressed: flat!.renter != null
          ? () async {
              Response res;
              if (flat.currentMeterReading == null) {
                AppWidget.showElectricityUnitDialog(context: context);
              }
              if (homeId != null && flat.currentMeterReading != null) {
                if (context.read<BillsProvider>().totalBill != null) {
                  res = await RecordService().createMonthlyRecord(
                    homeId: homeId,
                    flat: flat,
                    issueDate: issueDate,
                    meterReading: flat.currentMeterReading!,
                    renterPayable: context.read<BillsProvider>().totalBill!,
                  );
                  if (res.code == 200) {}
                }
              }
            }
          : null,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
