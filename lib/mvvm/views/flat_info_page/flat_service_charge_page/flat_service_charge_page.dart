import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/view_models/home_service_charge_view_model.dart';
import 'package:sweet_home/mvvm/views/waiting_pages/circular_indicator_waiting.dart';

import '../../empty_pages/empty_service_charge_page.dart';
import '../../error_pages/error_page.dart';
import 'components/service_charge_list.dart';

// ignore: must_be_immutable
class FlatServiceChargePage extends StatelessWidget {
  const FlatServiceChargePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeServiceChargeListViewModel>(context);
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
      //? MAKE IT VISIBLE IF YOU WANT USER TO ADD SERVICE CHARGE FOR INDIVIDUAL FLAT
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     AppWidget.getModalSheet(
      //         context: context, modalSheetContent: AddExpenceSheetContent());
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: ui,
    );
  }
}
