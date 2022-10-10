import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';

import '../../providers/current_home.dart';

import '../app_widgets.dart';
import '../resources/app_icons.dart';
import '../home_info_page/update_button.dart';
import '../../../prev/view/screens/shared_widgets/delete_button.dart';
import '../flat_info_page/compnents/divider.dart';
import '../shared_widgets/edit_textfield.dart';

//! information ought to be saved for all flats of home
class AllFlatsInfoPage extends StatelessWidget {
  AllFlatsInfoPage({super.key});
  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  final double dividerHorizontalSpacing = 16;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('আপনার ফ্ল্যাটের তথ্যাবলী'),
          centerTitle: true,
          actions: [
            IconButton(
              iconSize: 18,
              onPressed: () {
                AppWidget.showConfirmDialog(
                    context: context,
                    msg: 'তথ্যগুলি আপনার সকল ফ্ল্যাটের জন্য নির্ধারণ করা হবে');
              },
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: dividerHorizontalSpacing),
                child: FlatInfoDIvider(title: 'ফ্ল্যাটের তথ্য'),
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
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: dividerHorizontalSpacing),
                child: FlatInfoDIvider(title: 'বিল সমূহ'),
              ),
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
              //delete flat if renter does not exist
              DeleteButton(
                action: () {},
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  ListTile makeSingleListTile({
    required BuildContext context,
    IconData? leadingIcon,
    required String title,
    required String subtitleText,
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
