import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/view_models/service_charge_list_view_mode.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/service_charge_page/components/add_service_charge_sheet_content.dart';
import 'package:sweet_home/mvvm/views/waiting_pages/circular_indicator_waiting.dart';

import '../empty_pages/empty_service_charge_page.dart';
import '../error_pages/error_page.dart';
import 'components/service_charge_list.dart';

// ignore: must_be_immutable
class ServiceChargePage extends StatelessWidget {
  const ServiceChargePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ServiceChargeListViewModel>(context);
    Widget ui;
    switch (provider.status) {
      case Status.loading:
        ui = const CircularIndicator();
        break;
      case Status.error:
        ui = const ErrorPage();
        break;
      case Status.empty:
        ui = const EmptyServiceChargePage();
        break;
      case Status.completed:
        ui = const ServiceChargeList();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('অন্যান্য'),
        centerTitle: true,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppWidget.getModalSheet(
              context: context, modalSheetContent: AddExpenceSheetContent());
        },
        child: const Icon(Icons.add),
      ),
      body: ui,
    );
  }
}
