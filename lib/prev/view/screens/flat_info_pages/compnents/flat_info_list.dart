import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../mvvm/models/flat_model.dart';
import '../../../../models/response.dart';
import '../../../../../mvvm/providers/current_home.dart';
import '../../../../providers/flat_info_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../../mvvm/repositories/flat_services.dart';
import '../../../../services/record_services.dart';
import '../../../app_widgets.dart';
import '../../../resources/app_icons.dart';
import '../../home_info_page/edit_textfield.dart';
import '../../home_info_page/update_button.dart';
import '../../shared_widgets/delete_button.dart';
import 'divider.dart';

class FlatInfoList extends StatelessWidget {
  FlatInfoList({super.key});
  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  final double dividerHorizontalSpacing = 16;

  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> readingKey = GlobalKey();
    final previousController = TextEditingController();
    final currentController = TextEditingController();

    DateTime lastMonthDate =
        DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    String homeId = context.watch<CurrentHomeProvider>().currentHome!.homeId;
    Flat? flat = context.read<SelectedFlatProvider>().selectedFlat;

    double currentReading = flat?.currentMeterReading ?? 0.00;
    double? previousReading = flat?.previousMeterReading;
    bool isDark = context.watch<ThemeProvider>().isDarkMode;

    // previousController.text = flat!.previousMeterReading.toString();
    previousController.text =
        previousReading == null ? '' : previousReading.toString();
    currentController.text = currentReading.toString();

    CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();

    return flat == null
        ? const SizedBox()
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dividerHorizontalSpacing),
                  child: flatInfoDivider(context: context, text: 'মিটার'),
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
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 30),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Form(
                              key: context
                                  .read<CurrentHomeProvider>()
                                  .editFormKey,
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
                      height: MediaQuery.of(context).size.height * 0.70,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 30),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Form(
                              key: readingKey,
                              child: TextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'কোনও তথ্য দেয়া হয়নি';
                                  }
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
                            onUpdated: () async {
                              if (readingKey.currentState!.validate()) {
                                // update record
                                Response res = await RecordService()
                                    .updateRecord(
                                  homeId: homeId,
                                  flatName: flat.flatName,
                                  fieldName: 'meterReading',
                                  newReading:
                                      double.parse(previousController.text),
                                  recordDate: lastMonthDate,
                                )
                                    .whenComplete(() {
                                  FlatService().updateFlat(
                                      homeId: homeId,
                                      flatName: flat.flatName,
                                      fieldName: 'previousMeterReading',
                                      newValue: double.parse(
                                          previousController.text));
                                });
                                if (res.code == 200) {
                                  AppWidget.showToast('পরিবর্তন করা হয়েছে');
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                } else {
                                  AppWidget.showToast(
                                      'পরিবর্তন করা সম্ভব হয়নি');
                                }
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

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dividerHorizontalSpacing),
                  child: flatInfoDivider(context: context, text: 'বিল সমূহ'),
                ),
                // ListTile(
                //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //       builder: ((context) => ElectricityPage()))),
                //   leading: const Icon(Icons.electric_bolt_outlined),
                //   title: const Text('বৈদ্যুতিক মিটার'),
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios_rounded,
                //     size: 16,
                //   ),
                // ),
                makeSingleListTile(
                  context: context,
                  assetUrl: AppIcons.takaUrl,
                  title: 'ভাড়া',
                  subtitleText: '22400',
                  willNumeric: false,
                ),
                makeSingleListTile(
                  context: context,
                  leadingIcon: Icons.gas_meter_outlined,
                  title: 'গ্যাস',
                  subtitleText: '800',
                  willNumeric: false,
                ),
                makeSingleListTile(
                  context: context,
                  leadingIcon: Icons.water_drop_outlined,
                  title: 'পানি',
                  subtitleText: '300',
                  willNumeric: false,
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dividerHorizontalSpacing),
                  child:
                      flatInfoDivider(context: context, text: 'ফ্ল্যাটের তথ্য'),
                ),

                makeSingleListTile(
                  context: context,
                  leadingIcon: Icons.bed,
                  title: 'বেড ',
                  subtitleText: '3',
                  willNumeric: false,
                ),
                makeSingleListTile(
                  context: context,
                  leadingIcon: Icons.bathtub_outlined,
                  title: 'বাথ ',
                  subtitleText: '2',
                  willNumeric: false,
                ),
                makeSingleListTile(
                  context: context,
                  leadingIcon: Icons.camera_outdoor_outlined,
                  title: 'বারান্দা ',
                  subtitleText: '1',
                  willNumeric: false,
                ),
                makeSingleListTile(
                  context: context,
                  leadingIcon: Icons.dining_outlined,
                  title: 'ডাইনিং ',
                  subtitleText: '1',
                  willNumeric: false,
                ),
                makeSingleListTile(
                  context: context,
                  leadingIcon: Icons.chair,
                  title: 'ড্রইং ',
                  subtitleText: '1',
                  willNumeric: false,
                ),

                //delete flat if renter does not exist
                DeleteButton(
                  action: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
  }

  ListTile makeSingleListTile({
    required BuildContext context,
    IconData? leadingIcon,
    required String title,
    String subtitleText = '',
    bool isDouble = false,
    bool isInt = false,
    String? Function(String?)? validationFunciton,
    String? assetUrl,
    bool? willNumeric = true,
    bool isTappable = true,
  }) {
    bool isDark = context.watch<ThemeProvider>().isDarkMode;
    CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();
    return ListTile(
      onTap: !isTappable
          ? null
          : () => AppWidget.getModalSheet(
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
                      Text(
                        title,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Form(
                          key: context.read<CurrentHomeProvider>().editFormKey,
                          child: EditTextField(
                            validationFunciton: validationFunciton,
                            isNumeric: willNumeric ?? false,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      UpdateButton(
                        onUpdated: () {},
                      ),
                    ],
                  ),
                ),
              ),
      leading: assetUrl == null
          ? Icon(
              leadingIcon,
              color: isDark ? colorInDarkMode : colorInLightMode,
            )
          //asset used instead of icon in 'Rent Amount'
          : Image.asset(
              assetUrl,
              height: 20,
              color: isDark ? colorInDarkMode : colorInLightMode,
            ),
      title: Text(title),
      subtitle: Text(
        subtitleText.toString(),
        style: TextStyle(
          color: isDark ? colorInDarkMode : colorInLightMode,
        ),
      ),
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
