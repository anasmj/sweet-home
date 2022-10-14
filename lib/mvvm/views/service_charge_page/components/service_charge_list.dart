import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/service_charge_list_view_mode.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';

import 'LongPressSheetOptions.dart';
import 'on_tap_sheet_options.dart';

class ServiceChargeList extends StatelessWidget {
  const ServiceChargeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ServiceChargeListViewModel>(context);

    return ListView(
      children: provider.chargeList.map((item) {
        return ListTile(
          onTap: () {
            AppWidget.getModalSheet(
              context: context,
              modalSheetContent: const OnTapSheetOption(),
            );
          },
          onLongPress: () {
            AppWidget.getModalSheet(
              context: context,
              modalSheetContent: const LongPressSheetOptions(),
            );
          },
          title: Text(item.purpose),
          subtitle: Text(
            Formatter.toBn(
              value: item.amount,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // subtitle: Text('৳ ${item.amount.toStringAsFixed(1)}'),
        );
      }).toList(),
    );
  }
}
