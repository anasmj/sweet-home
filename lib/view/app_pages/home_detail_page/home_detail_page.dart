import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/view/app_pages/home_detail_page/update_button.dart';
import '../../../providers/current_home.dart';
import '../../../providers/theme_provider.dart';
import '../../../services/database_service/home_crud.dart';
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
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  final displayFieldToDbField = {
    //app field | DB fields
    'বাড়ীর নাম': 'Home Name',
    'ভাড়া': 'Rent Amount',
    'ঠিকানা': 'Location',
    'তলা': 'Floor',
    'ফ্লোরে ফ্ল্যাট সংখ্যা': 'Flat Per Floor',
    'গ্যাস': 'Gas Bill',
    'পানি': 'Water Bill',
    // 'অন্যান্য' : 'Others'
  };

  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider provider = context.read<CurrentHomeProvider>();

    // provider.nameController.text = home.homeName;
    // provider.rentController.text = home.rentAmount.toString();
    // provider.locationController.text = home.location;
    // provider.gasController.text = home.gasBill.toString();
    // provider.waterController.text = home.waterBill.toString();
    // provider.floorController.text = home.flatPerFloor.toString();
    // provider.flatNumController.text = home.flatPerFloor.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(home.homeName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            makeSingleListTile(
              context: context,
              leadingIcon: Icons.home_filled,
              title: 'বাড়ীর নাম',
              subtitle: home.homeName,
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
              subtitle: home.rentAmount.toString(),
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
              validationFunciton: (String? value) {
                return Utils.compareValues(
                  value: value!,
                  compareWith: home.waterBill.toString(),
                  isRequired: false,
                );
              },
            ),
            ListTile(
              onTap: () => AppWidget.showToast('Work in progress..'),
              leading: const Icon(Icons.add_home_work_rounded),
              title: const Text('অন্যান্য'),
              subtitle: const Text('অন্যান্য খরচ'),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DeleteButton(
              onHomeDeleted: () {
                Home? currentHome =
                    context.read<CurrentHomeProvider>().getCurrentHome;
                if (currentHome != null) {
                  Response response = HomeCrud().deleteHome(home.homeId);
                  if (response.code != 200) {
                    AppWidget.snackBarContent(
                        msg: 'বাড়ীটি ডিলিট করা সম্ভব হয়নি');
                  }
                  AppWidget.showToast('বাড়ীটি মুছে ফেলা হয়েছে');
                  context.read<CurrentHomeProvider>().setCurrentHome(null);
                  //close drawer
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile makeSingleListTile({
    required BuildContext context,
    IconData? leadingIcon,
    required String title,
    required String subtitle,
    // TextEditingController? controller,
    String? Function(String?)? validationFunciton,
    String? assetUrl,
    bool? willNumeric = true,
  }) {
    bool isDark = context.watch<ThemeProvider>().isDarkMode;
    CurrentHomeProvider provider = context.read<CurrentHomeProvider>();

    return ListTile(
      onTap: () {
        provider.displayTextController.text = subtitle;
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
                    child: divider(isDark),
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
                        // textEditingController: controller,
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
                    homeId: home.homeId,
                    dbFieldName: getFirebaseFieldName(title: title),
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

  RoundedRectangleBorder modalSheetStyle() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
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

  String getFirebaseFieldName({required String title}) {
    String selectedFirebaseField;
    selectedFirebaseField = displayFieldToDbField[title] ?? 'Not found';
    return selectedFirebaseField;
  }
}
