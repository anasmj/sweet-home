import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/models/response.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/services/flat_services.dart';
import 'package:sweet_home/services/record_services.dart';

import '../../../models/flat_model.dart';
import '../../../providers/current_home.dart';
import '../../../providers/theme_provider.dart';
import '../../app_widgets.dart';
import '../home_info_page/edit_textfield.dart';
import '../home_info_page/update_button.dart';

class ElectricityPage extends StatelessWidget {
  ElectricityPage({super.key});

  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final previousController = TextEditingController();
    final currentController = TextEditingController();

    DateTime lastMonthDate =
        DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    String homeId = context.watch<CurrentHomeProvider>().currentHome!.homeId;
    Flat? flat = context.read<SelectedFlatProvider>().selectedFlat;

    double currentReading = flat?.currentMeterReading ?? 0.00;
    double previousReading = flat?.previousMeterReading ?? 0.00;
    bool isDark = context.watch<ThemeProvider>().isDarkMode;

    // previousController.text = flat!.previousMeterReading.toString();
    previousController.text = previousReading.toString();

    return WillPopScope(
      onWillPop: () async {
        currentController.clear();
        previousController.clear();

        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('মিটার সংক্রান্ত'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              ListTile(
                onTap: () => AppWidget.getModalSheet(
                  context: context,
                  isDark: isDark,
                  modalSheetContent: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                          child: modalSheetDivider(isDark),
                        ),
                        const Text(
                          'বর্তমান  রিডিং',
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Form(
                            key:
                                context.read<CurrentHomeProvider>().editFormKey,
                            child: const TextField(
                              // controller: currentController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        UpdateButton(
                          onUpdated: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                title: const Text('বর্তমান  রিডিং'),
                subtitle: currentReading != null
                    ? Text(currentController.text)
                    : const Text('দেওয়া নেই'),
              ),
              ListTile(
                onTap: () => AppWidget.getModalSheet(
                  context: context,
                  isDark: isDark,
                  modalSheetContent: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                          child: modalSheetDivider(isDark),
                        ),
                        const Text(
                          'পূর্বের রিডিং',
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: previousController,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        UpdateButton(
                          onUpdated: () async {
                            // update record
                            Response res = await RecordService()
                                .updateRecord(
                              homeId: homeId,
                              flatName: flat?.flatName ?? '',
                              fieldName: 'meterReading',
                              newReading: double.parse(previousController.text),
                              recordDate: lastMonthDate,
                            )
                                .whenComplete(() {
                              FlatService().updateFlat(
                                  homeId: homeId,
                                  flatName: flat?.flatName ?? '',
                                  fieldName: 'previousMonthMeterReading',
                                  newValue:
                                      double.parse(previousController.text));
                            });
                            if (res.code == 200) {
                              AppWidget.showToast('পরিবর্তন করা হয়েছে');
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            } else {
                              AppWidget.showToast('পরিবর্তন করা সম্ভব হয়নি');
                            }
                            //update flat field
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                title: const Text('পূর্বের রিডিং'),
                subtitle: previousReading != null
                    ? Text(previousController.text)
                    : const SizedBox(),
              ),
            ],
          )),
    );
  }

  Container modalSheetDivider(bool isDarkMode) {
    return Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: isDarkMode ? Colors.white60 : Colors.grey.shade700,
      ),
      height: 4,
      width: 20,
    );
  }
}
