import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/view/app_pages/home_detail_page/update_button.dart';
import '../../../providers/current_home.dart';
import '../../../providers/theme_provider.dart';
import '../../../services/database_service/home_crud.dart';
import '../../../utils/home_crud.dart';
import '../../app_widgets.dart';
import 'package:sweet_home/view/app_pages/home_detail_page/edit_textfield.dart';
import '../../../models/response.dart';
import '../../../utils/compare_values.dart';
import '../../../models/home_model.dart';
import '../../resources/app_icons.dart';
import 'delete_button.dart';

//* Takes a Home object and displaies its property allowing to fields in database
class HomeDetail extends StatelessWidget {
  HomeDetail({required this.home, super.key});

  Home home;
  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  // GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider provider = context.read<CurrentHomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(home.homeName),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            makeSingleListTile(
              context: context,
              leadingIcon: Icons.home_filled,
              title: 'বাড়ীর নাম',
              subtitleText: home.homeName,
              validationFunciton: (String? value) {
                return Utils.compareValues(
                  value: value!,
                  compareWith: home.homeName.toString(),
                );
              },
              willNumeric: false,
            ),
            makeSingleListTile(
              context: context,
              assetUrl: AppIcons.takaUrl,
              title: 'ভাড়া',
              isDouble: true,
              subtitleText: home.rentAmount.toString(),
              validationFunciton: (String? value) {
                return Utils.compareValues(
                  value: value!,
                  compareWith: home.rentAmount.toString(),
                );
              },
            ),
            makeSingleListTile(
              context: context,
              leadingIcon: Icons.pin_drop,
              title: 'ঠিকানা',
              subtitleText: home.location,
              willNumeric: false,
              validationFunciton: (String? value) {
                return Utils.compareValues(
                  value: value!,
                  compareWith: home.location.toString(),
                );
              },
            ),
            makeSingleListTile(
              context: context,
              leadingIcon: Icons.format_list_numbered_rounded,
              title: 'তলা',
              isInt: true,
              subtitleText: home.floor.toString(),
              validationFunciton: (String? value) {
                return Utils.compareValues(
                  value: value!,
                  compareWith: home.floor.toString(),
                );
              },
            ),
            makeSingleListTile(
              context: context,
              leadingIcon: Icons.view_column,
              title: 'ফ্লোরে ফ্ল্যাট সংখ্যা',
              isInt: true,
              subtitleText: home.flatPerFloor.toString(),
              validationFunciton: (String? value) {
                return Utils.compareValues(
                  value: value!,
                  compareWith: home.flatPerFloor.toString(),
                );
              },
            ),
            makeSingleListTile(
              context: context,
              leadingIcon: Icons.gas_meter_outlined,
              title: 'গ্যাস',
              isDouble: true,
              subtitleText: home.gasBill.toString(),
              validationFunciton: (String? value) {
                return Utils.compareValues(
                  value: value!,
                  compareWith: home.gasBill.toString(),
                  isRequired: false,
                );
              },
            ),
            makeSingleListTile(
              context: context,
              leadingIcon: Icons.water_drop_outlined,
              title: 'পানি',
              isDouble: true,
              subtitleText: home.waterBill.toString(),
              validationFunciton: (String? value) {
                return Utils.compareValues(
                  value: value!,
                  compareWith: home.waterBill.toString(),
                  isRequired: false,
                );
              },
            ),
            othersListTile(),
            const SizedBox(
              height: 20,
            ),
            DeleteButton(
              onHomeDeleted: () => onHomeDeleted(context),
            ),
          ],
        ),
      ),
    );
  }

  ListTile othersListTile() {
    return ListTile(
      onTap: () => AppWidget.showToast('Work in progress..'),
      leading: const Icon(Icons.add_home_work_rounded),
      title: const Text('অন্যান্য'),
      subtitle: const Text('অন্যান্য খরচ'),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
      ),
    );
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
  }) {
    bool isDark = context.watch<ThemeProvider>().isDarkMode;
    CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();
    return ListTile(
      onTap: () {
        providerRead.displayTextController.text = subtitleText;
        showModalBottomSheet(
          backgroundColor: isDark ? modalSheetBgDark : modalSheetBgLight,
          isScrollControlled: true,
          shape: modalSheetStyle(),
          context: context,
          // isScrollControlled: true,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
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
                    onUpdated: () => onUpdateField(
                      context: context,
                      home: home,
                      title: title,
                      //for typecasting purpose
                      isDouble: isDouble,
                      isInt: isInt,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
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

  RoundedRectangleBorder modalSheetStyle() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
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
