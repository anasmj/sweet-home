import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/service_charges.dart';
import 'package:sweet_home/mvvm/view_models/service_charge_list_view_mode.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/empty_pages/empty_home_page.dart';
import 'package:sweet_home/mvvm/views/service_charge_page/components/add_service_charge_sheet_content.dart';
import 'package:sweet_home/mvvm/views/service_charge_page/components/service_charge_options_sheet_content.dart';
import 'package:sweet_home/mvvm/views/waiting_pages/circular_indicator_waiting.dart';

import '../error_pages/error_page.dart';

// ignore: must_be_immutable
class ServiceChargePage extends StatelessWidget {
  ServiceChargePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ServiceChargeListViewModel>(context);
    // Widget ui;
    // switch (provider.status) {
    //   case Status.loading:
    //     ui = const CircularIndicator();
    //     break;
    //   case Status.error:
    //     ui = const ErrorPage();
    //     break;
    //   case Status.empty:
    //     ui = const EmptyHomePage();
    //     break;
    //   case Status.completed:
    //     ui = showList(provider.chargeList);
    //     break;
    // }

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
              context: context,
              modalSheetContent: const AddExpenceSheetContent());
        },
        child: const Icon(Icons.add),
      ),
      // body: ui,
      body: Container(),
      // body: provider.status == Status.loading
      //     ? const CircularIndicator()
      //     : provider.status == Status.empty
      //         ? const EmptyHomePage()
      //         : Container(),
    );
  }

  Widget showList(List<ServiceCharge> expenceList) {
    return Builder(builder: (context) {
      return ListView(
        children: expenceList.map((item) {
          return ListTile(
            onTap: () {
              AppWidget.getModalSheet(
                  context: context,
                  modalSheetContent: const ExpenctOptionsSheetContent());
            },
            title: Text(item.purpose),
            subtitle: Text('৳ ${item.amount.toStringAsFixed(1)}'),
          );
        }).toList(),
      );
    });
  }
}
