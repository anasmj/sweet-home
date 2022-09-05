import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/views/shared_widgets.dart';
import 'package:sweet_home/views/user_home_detail_page/components/edit_textfield.dart';

import '../../../controllers/form_validators.dart';
import '../../../models/home_model.dart';
import '../../styling/app_icons.dart';

class HomeContent extends StatelessWidget {
  HomeContent({
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
        title: Text(home.homeName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            makeListTile(
              context: context,
              leadingIcon: Icons.home_filled,
              title: 'বাড়ীর নাম',
              subtitle: home.homeName,
              contrller: nameController,
              validationFunciton: (String? value) {
                return compareValues(
                  value: value!,
                  compareWith: home.homeName.toString(),
                );
              },
              // validationFunciton: FormValidators.checkEmpty,
              willNumeric: false,
            ),
            makeListTile(
              context: context,
              assetUrl: AppIcons.takaUrl,
              title: 'ভাড়া',
              subtitle: home.rentAmount.toString(),
              contrller: rentController,
              validationFunciton: (String? value) {
                return compareValues(
                  value: value!,
                  compareWith: home.floor.toString(),
                );
              },
            ),
            makeListTile(
              context: context,
              leadingIcon: Icons.pin_drop,
              title: 'ঠিকানা',
              subtitle: home.location,
              contrller: locationController,
              willNumeric: false,
              validationFunciton: (String? value) {
                return compareValues(
                  value: value!,
                  compareWith: home.location.toString(),
                );
              },
            ),
            makeListTile(
              context: context,
              leadingIcon: Icons.format_list_numbered_rounded,
              title: 'তলা',
              subtitle: home.floor.toString(),
              contrller: floorController,
              validationFunciton: (String? value) {
                return compareValues(
                  value: value!,
                  compareWith: home.floor.toString(),
                );
              },
            ),
            makeListTile(
              context: context,
              leadingIcon: Icons.view_column,
              title: 'ফ্লোরে ফ্ল্যাট সংখ্যা',
              subtitle: home.flatPerFloor.toString(),
              contrller: flatNumController,
              validationFunciton: (String? value) {
                return compareValues(
                  value: value!,
                  compareWith: home.flatPerFloor.toString(),
                );
              },
            ),
            makeListTile(
              context: context,
              leadingIcon: Icons.gas_meter_outlined,
              title: 'গ্যাস',
              subtitle: home.gasBill.toString(),
              contrller: gasController,
              validationFunciton: (String? value) {
                return compareValues(
                  value: value!,
                  compareWith: home.gasBill.toString(),
                  isRequired: false,
                );
              },
            ),
            makeListTile(
              context: context,
              leadingIcon: Icons.water_drop_outlined,
              title: 'পানি',
              subtitle: home.waterBill.toString(),
              contrller: waterController,
              validationFunciton: (String? value) {
                return compareValues(
                  value: value!,
                  compareWith: home.gasBill.toString(),
                  isRequired: false,
                );
              },
            ),
            makeListTile(
              context: context,
              leadingIcon: Icons.add_home_work_rounded,
              title: 'অন্যান্য',
              subtitle: 'on precess ',
              contrller: otherController,
            ),
          ],
        ),
      ),
    );
  }

  //returns null if valuse are different and empty
  String? compareValues(
      {required String value,
      required String compareWith,
      bool isRequired = true}) {
    if (isRequired) {
      if (value.isEmpty) {
        return 'কোনও তথ্য দেয়া হয়নি';
      }
      if (value.trim() == compareWith.trim()) {
        return 'কোনও তথ্য পরিবর্তন হয়নি';
      } else {
        return null;
      }
    } else {
      if (value.trim() == compareWith.trim()) {
        return 'কোনও তথ্য পরিবর্তন হয়নি';
      } else {
        return null;
      }
    }
  }

  ListTile makeListTile({
    required BuildContext context,
    IconData? leadingIcon,
    required String title,
    required String subtitle,
    required TextEditingController contrller,
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
              controller: contrller,
              validationFunciton: validationFunciton,
              willNumeric: willNumeric,
            );
          }),
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              if (editFormKey.currentState!.validate()) {
                print('need to update');
              } else {
                AppWidget.showToast('আপডেট করা সম্ভব হয়নি');
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('আপডেট',
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ),
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
