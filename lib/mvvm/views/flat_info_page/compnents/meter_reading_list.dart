import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/services/record_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/update_button.dart';

// ignore: must_be_immutable
class MeterReadingList extends StatelessWidget {
  MeterReadingList({super.key, required this.flat});
  Flat flat;
  String currentReadingString = 'দেওয়া নেই';
  String previousReadingString = 'দেওয়া নেই';
  bool isCurrentReadingNull = true;
  bool isPreviousReadingNull = true;
  DateTime currentDate = DateTime.now();
  GlobalKey<FormState> readingKey = GlobalKey();
  final previousController = TextEditingController();
  final currentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String homeId = context.watch<CurrentHomeProvider>().currentHome!.homeId;

    double currentReading = flat.currentMeterReading ?? 0.00;
    double? previousReading = flat.previousMeterReading;
    previousController.text =
        previousReading == null ? '' : previousReading.toString();
    currentController.text = currentReading.toString();

    if (flat.currentMeterReading != null) {
      currentReadingString = flat.currentMeterReading!.toStringAsFixed(1);
      isCurrentReadingNull = false;
    }
    if (flat.previousMeterReading != null) {
      flat.previousMeterReading!.toStringAsFixed(1);
      previousReadingString = flat.previousMeterReading.toString();
      isPreviousReadingNull = false;
    }

    return Column(
      children: [
        ListTile(
          leading: isCurrentReadingNull ? pendingIcon() : tickIcon(),
          title: const Text('বর্তমান  রিডিং'),
          subtitle: Text(currentReadingString),
          onTap: () => AppWidget.getModalSheet(
            context: context,
            modalSheetContent: updateModalSheetContent(),
          ),
        ),
        ListTile(
          onTap: () => AppWidget.getModalSheet(
            context: context,
            modalSheetContent: updateModalSheetContent(forPreviousMonth: true),
          ),
          leading: isPreviousReadingNull ? pendingIcon() : tickIcon(),
          title: const Text('পূর্বের রিডিং'),
          subtitle: Text(previousReadingString),
        ),
      ],
    );
  }

  Widget updateModalSheetContent({bool forPreviousMonth = false}) {
    return Builder(builder: (context) {
      String homeId = context.watch<CurrentHomeProvider>().currentHome!.homeId;
      DateTime lastMonthDate =
          DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
      DateTime currentMonthDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day);

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
                key: readingKey,
                child: TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'কোনও তথ্য দেয়া হয়নি';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: previousController,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            UpdateButton(
              buttonTitle: 'আপডেট',
              onPressed: () async {
                if (readingKey.currentState!.validate()) {
                  // update record
                  Response res = await RecordService()
                      .updateRecord(
                    homeId: homeId,
                    flatName: flat.flatName,
                    fieldName: 'meterReading',
                    newReading: forPreviousMonth
                        ? double.parse(previousController.text)
                        : double.parse(previousController.text),
                    recordDate:
                        forPreviousMonth ? lastMonthDate : currentMonthDate,
                  )
                      .whenComplete(() {
                    FlatService().updateFlat(
                        homeId: homeId,
                        flatName: flat.flatName,
                        fieldName: 'previousMeterReading',
                        newValue: double.parse(previousController.text));
                  });
                  if (res.code == 200) {
                    AppWidget.showToast('পরিবর্তন করা হয়েছে');
                    previousController.clear();
                    currentController.clear();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  } else {
                    AppWidget.showToast('পরিবর্তন করা সম্ভব হয়নি');
                  }
                }

                //update flat field
              },
            ),
          ],
        ),
      );
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
