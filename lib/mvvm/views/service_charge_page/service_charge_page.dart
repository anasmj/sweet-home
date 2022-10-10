import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/service_charges.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/service_charge_page/components/add_service_charge_sheet_content.dart';
import 'package:sweet_home/mvvm/views/service_charge_page/components/service_charge_options_sheet_content.dart';

// ignore: must_be_immutable
class OtherExpencesPage extends StatelessWidget {
  List<Map<String, dynamic>>? othersList;
  OtherExpencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('অন্যান্য '),
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
      body: _demoServiceChargeList != null
          ? showList(_demoServiceChargeList)
          : const SizedBox.shrink(),
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

  final List<ServiceCharge> _demoServiceChargeList = [
    ServiceCharge(purpose: 'Lift', amount: 231),
    ServiceCharge(purpose: 'Security', amount: 223),
    ServiceCharge(purpose: 'Cleaning', amount: 2131),
  ];
}
