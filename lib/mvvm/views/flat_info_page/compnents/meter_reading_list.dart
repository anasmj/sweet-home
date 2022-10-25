import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/services/record_services.dart';
import 'package:sweet_home/mvvm/utils/form_validators.dart';
import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/update_button.dart';

// ignore: must_be_immutable
class MeterReadingList extends StatelessWidget {
  MeterReadingList({super.key, required this.flat});
  Flat flat;
  // String currentReadingString = 'দেওয়া নেই';
  // String previousReadingString = 'দেওয়া নেই';
  bool isCurrentReadingNull = true;
  bool isPreviousReadingNull = true;
  DateTime currentDate = DateTime.now();
  GlobalKey<FormState> readingKey = GlobalKey();
  final previousController = TextEditingController();
  final currentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          trailing: Text('12 jan 03:03pm'),
          leading:
              flat.currentMeterReading == null ? pendingIcon() : tickIcon(),
          title: const Text('বর্তমান  রিডিং'),
          subtitle: Text(flat.currentMeterReading != null
              ? flat.currentMeterReading.toString()
              : 'দেওয়া নেই'),
          onTap: () => AppWidget.getModalSheet(
            context: context,
            modalSheetContent: updateModalSheetContent(),
          ),
        ),
        ListTile(
          leading:
              flat.previousMeterReading == null ? pendingIcon() : tickIcon(),
          title: const Text('পূর্বের রিডিং'),
          subtitle: Text(flat.previousMeterReading != null
              ? flat.previousMeterReading.toString()
              : 'দেওয়া নেই'),
          trailing: Text('12 feb 07:03pm'),
          onTap: () => AppWidget.getModalSheet(
            context: context,
            modalSheetContent: updateModalSheetContent(forPreviousMonth: true),
          ),
        ),
      ],
    );
  }

  Widget updateModalSheetContent({bool forPreviousMonth = false}) {
    return Builder(builder: (context) {
      // String homeId = context.watch<CurrentHomeProvider>().currentHome!.homeId;

      // DateTime currentMonthDate =
      //     DateTime(currentDate.year, currentDate.month, currentDate.day);

      return Builder(builder: (context) {
        final viewModel = Provider.of<FlatListViewModel>(context);
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.70,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                child: modalSheetDivider(),
              ),
              Text(
                forPreviousMonth ? 'পূর্বের রিডিং' : 'বর্তমান  রিডিং',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: viewModel.meterReadingKey,
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null) return 'তথ্যটি দেয়া হয়নি';
                      if (value.isEmpty) return 'তথ্যটি দেয়া হয়নি';
                      if (!forPreviousMonth) {
                        if (double.parse(value) == 0) return 'তথ্যটি সঠিক নয়';
                        if (double.parse(value) <= flat.previousMeterReading!) {
                          return 'বর্তমান রিডিং পূর্বের চেয়ে অধিক হতে হবে';
                        }
                      }
                      if (flat.currentMeterReading != null) {
                        if (double.parse(value) > flat.currentMeterReading!) {
                          return 'পূর্বের রিডিং বর্তমানের চেয়ে কম হতে হবে';
                        }
                      }
                      if (double.tryParse(value) == null) {
                        return 'তথ্যটি সঠিক নয়';
                      }
                      if (flat.previousMeterReading == null) {
                        return 'পূর্বের রিডিং দেয়া হয়নি';
                      }
                      if (value == '.') return 'তথ্যটি সঠিক নয়';
                      if (double.parse(value) < 0) return 'তথ্যটি সঠিক নয়';

                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: forPreviousMonth
                        ? viewModel.previousMeterController
                        : viewModel.currentMeterController,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              UpdateButton(
                buttonTitle: 'আপডেট',
                onPressed: () async {
                  if (viewModel.meterReadingKey.currentState!.validate()) {
                    Response? res = forPreviousMonth
                        ? await viewModel.updatePreviousMonthMeterReading()
                        : await viewModel.updateCurrentMonthMeterReading();
                    if (res.code == 200) {
                      AppWidget.showToast('আপডেট সম্পন্ন হয়েছে');
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                    previousController.clear();
                    currentController.clear();
                    //! DO NOT DELETE WITHOUT PROPER UNDERSTAANDING
                    // update record
                    //   Response res = await RecordService()
                    //       .updateRecord(
                    //     homeId: homeId,
                    //     flatName: flat.flatName,
                    //     fieldName: 'meterReading',
                    //     newReading: forPreviousMonth
                    //         ? double.parse(previousController.text)
                    //         : double.parse(previousController.text),
                    //     recordDate:
                    //         forPreviousMonth ? lastMonthDate : currentMonthDate,
                    //   )
                    //       .whenComplete(() {
                    //     FlatService().updateFlat(
                    //       homeId: homeId,
                    //       flatName: flat.flatName,
                    //       fieldName: 'previousMeterReading',
                    //       newValue: double.parse(previousController.text),
                    //     );
                    //   });
                    //   if (res.code == 200) {
                    //     AppWidget.showToast('পরিবর্তন করা হয়েছে');
                    //     previousController.clear();
                    //     currentController.clear();
                    //     // ignore: use_build_context_synchronously
                    //     Navigator.of(context).pop();
                    //   } else {
                    //     AppWidget.showToast('পরিবর্তন করা সম্ভব হয়নি');
                    //   }
                  }
                },
              ),
            ],
          ),
        );
      });
    });
  }

  Widget modalSheetDivider() {
    return Builder(builder: (context) {
      bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
      return Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: isDarkMode ? Colors.white60 : Colors.grey.shade700,
        ),
        height: 4,
        width: 20,
      );
    });
  }

  Icon tickIcon() =>
      const Icon(Icons.check_circle, color: Colors.green, size: 22);
  Icon pendingIcon() => const Icon(FontAwesomeIcons.circleQuestion,
      color: Colors.orange, size: 22);
}
