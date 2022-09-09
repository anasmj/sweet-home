import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/view/app_pages/current_home_detail_page/components/update_button.dart';
import 'package:sweet_home/view/app_widgets.dart';
import 'package:sweet_home/view/app_pages/current_home_detail_page/components/edit_textfield.dart';

import '../../../../utils/compare_values.dart';
import '../../../../utils/form_validators.dart';
import '../../../../models/home_model.dart';
import '../../../resources/app_icons.dart';
import 'delete_button.dart';

class HomeDetailContent extends StatelessWidget {
  HomeDetailContent({
    Key? key,
    required this.home,
  }) : super(key: key);
  final Home home;

  TextEditingController nameController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController gasController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController flatNumController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;

  final displayFieldToDbField = {
    'বাড়ীর নাম': 'Home Name',
    'ভাড়া': 'Rent Amount',
    'ঠিকানা': 'Location',
    'তলা': 'Floor',
    'ফ্লোরে ফ্ল্যাট সংখ্যা': 'Flat Per Floor',
    'গ্যাস': 'Gas Bill',
    'পানি': 'Water Bill',
    // 'অন্যান্য' : 'Others'
  };

  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameController.text = home.homeName.trim();
    rentController.text = home.rentAmount.toString();
    locationController.text = home.location;
    gasController.text = home.gasBill.toString();
    waterController.text = home.waterBill.toString();
    floorController.text = home.floor.toString();
    flatNumController.text = home.flatPerFloor.toString();

    bool buttonShouldActive = false;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: modalSheetTitleText(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              makeSingleListTile(
                context: context,
                leadingIcon: Icons.home_filled,
                title: 'বাড়ীর নাম',
                subtitle: home.homeName,
                controller: nameController,
                validationFunciton: (String? value) {
                  return Utils.compareValues(
                    value: value!,
                    compareWith: home.homeName.toString(),
                  );
                },
                // validationFunciton: FormValidators.checkEmpty,
                willNumeric: false,
              ),
              makeSingleListTile(
                context: context,
                assetUrl: AppIcons.takaUrl,
                title: 'ভাড়া',
                subtitle: home.rentAmount.toString(),
                controller: rentController,
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
                subtitle: home.location,
                controller: locationController,
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
                subtitle: home.floor.toString(),
                controller: floorController,
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
                subtitle: home.flatPerFloor.toString(),
                controller: flatNumController,
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
                subtitle: home.gasBill.toString(),
                controller: gasController,
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
                subtitle: home.waterBill.toString(),
                controller: waterController,
                validationFunciton: (String? value) {
                  return Utils.compareValues(
                    value: value!,
                    compareWith: home.waterBill.toString(),
                    isRequired: false,
                  );
                },
              ),
              makeSingleListTile(
                context: context,
                leadingIcon: Icons.add_home_work_rounded,
                title: 'অন্যান্য',
                subtitle: 'on precess ',
                controller: otherController,
              ),
              const SizedBox(
                height: 20,
              ),
              DeleteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Text modalSheetTitleText() {
    return Text(
      home.homeName,
      style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
      overflow: TextOverflow.fade,
      softWrap: true,
    );
  }

  ListTile makeSingleListTile({
    required BuildContext context,
    IconData? leadingIcon,
    required String title,
    required String subtitle,
    required TextEditingController controller,
    String? Function(String?)? validationFunciton,
    String? assetUrl,
    bool? willNumeric = true,
  }) {
    bool isDark = context.watch<ThemeProvider>().isDarkMode;
    return ListTile(
      onTap: () => showModalBottomSheet(
        backgroundColor: isDark ? modalSheetBgDark : modalSheetBgLight,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        context: context,
        // isScrollControlled: true,
        builder: (context) {
          return modalContent(
            context: context,
            title: title,
            controller: controller,
            validationFunciton: validationFunciton,
            willNumeric: willNumeric,
          );
        },
      ),
      leading: assetUrl == null
          ? Icon(
              leadingIcon,
              color: isDark ? colorInDarkMode : colorInLightMode,
            )
          : Image.asset(
              assetUrl,
              height: 20,
              color: isDark ? colorInDarkMode : colorInLightMode,
            ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDark ? colorInDarkMode : colorInLightMode,
        ),
      ),
    );
  }

  String getFirebaseFieldName({required String title}) {
    String selectedFirebaseField;
    selectedFirebaseField = displayFieldToDbField[title] ?? 'Not found';
    return selectedFirebaseField;
  }

  Widget modalContent({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    String? Function(String?)? validationFunciton,
    bool? willNumeric = true,
  }) {
    bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 30),
            child: divider(isDarkMode),
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
              key: editFormKey,
              child: EditTextField(
                textEditingController: controller,
                validationFunciton: validationFunciton,
                isNumeric: willNumeric ?? false,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          // updateElevatedButton(),
          UpdateButton(
            editFormKey: editFormKey,
            fieldName: getFirebaseFieldName(title: title),
          ),
        ],
      ),
    );
  }

  Container divider(bool isDarkMode) {
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
