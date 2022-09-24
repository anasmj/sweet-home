import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/models/response.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/services/record_services.dart';
import 'package:sweet_home/view/app_widgets.dart';

import '../../../../models/flat_model.dart';
import '../../../../models/renter.dart';
import '../../../../providers/monthly_record_provider.dart';
import '../../../../view_models/renter_opening_page_view_model.dart';

// ignore: must_be_immutable
class BottomButton extends StatelessWidget {
  BottomButton({
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
    DateTime issueDate = DateTime.now();

    double? meterReading = context.watch<RenterOpeningViewModel>().meterReading;

    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      minWidth: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      color: Theme.of(context).secondaryHeaderColor,
      disabledColor: Colors.grey,
      onPressed: () async {
        if (providerWatch.meterReading == null) {
          AppWidget.showElectricityUnitDialog(context: context);
        }
        if (homeId != null && flat != null && meterReading != null) {
          Response res = await RecordService().createMonthlyRecord(
            homeId: homeId,
            flat: flat,
            issueDate: issueDate,
            meterReading: meterReading,
          );
          print(res.code); //todo: fix lagging
        }
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
