import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/models/response.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/services/renter_services.dart';
import 'package:sweet_home/view/app_widgets.dart';

import '../../../../models/flat_model.dart';
import '../../../../models/renter.dart';
import '../../../../providers/monthly_record_provider.dart';

// ignore: must_be_immutable
class BottomButton extends StatelessWidget {
  BottomButton({
    required this.text,
    Key? key,
  }) : super(key: key);

  String text;
  @override
  Widget build(BuildContext context) {
    MonthlyRecordProvider providerWatch =
        context.watch<MonthlyRecordProvider>();
    String? homeId = context.watch<CurrentHomeProvider>().currentHome?.homeId;
    Flat? flat = context.watch<CurrentFlatInfoProvider>().selectedFlat;
    DateTime issueDate = DateTime.now();

    double? meterReading = context.watch<MonthlyRecordProvider>().meterReading;

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
          Response res = await RenterService().createMonthlyRecord(
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
