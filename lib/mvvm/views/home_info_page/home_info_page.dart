import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sweet_home/mvvm/views/home_info_page/option_tile.dart';
import 'package:sweet_home/prev/utils/home_crud.dart';
import 'package:sweet_home/prev/view/screens/shared_widgets/delete_button.dart';
import '../../../prev/utils/routes.dart';
import '../../../prev/utils/compare_values.dart';
import '../../models/home_model.dart';
import '../service_charge_page/others_expences_page.dart';

// ignore: must_be_immutable
class HomeInfoPage extends StatelessWidget {
  HomeInfoPage({required this.home, super.key});

  Home home;
  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  // GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  final String addNewHome = 'বাড়ী যুক্ত';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(home.homeName),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => AppRoute.newHomeStepper(context: context),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          OptionTile(
            home: home,
            leadingIcon: Icons.home_filled,
            title: 'বাড়ীর নাম',
            subTitle: home.homeName,
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.homeName.toString(),
              );
            },
            isNumeric: false,
          ),
          OptionTile(
            home: home,
            leadingIcon: Icons.money_rounded,
            isDouble: true,
            title: 'ভাড়া',
            subTitle: '৳ ${home.rentAmount.toStringAsFixed(1)}',
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.rentAmount.toString(),
              );
            },
          ),

          OptionTile(
            home: home,
            leadingIcon: Icons.pin_drop,
            title: 'ঠিকানা',
            subTitle: home.location,
            isNumeric: false,
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.location.toString(),
              );
            },
          ),

          OptionTile(
            home: home,
            leadingIcon: Icons.gas_meter_outlined,
            title: 'গ্যাস',
            isDouble: true,
            subTitle: '৳ ${home.gasBill.toString()}',
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.gasBill.toString(),
                isRequired: false,
              );
            },
          ),
          OptionTile(
            home: home,
            leadingIcon: Icons.water_drop_outlined,
            title: 'পানি',
            isDouble: true,
            subTitle: '৳ ${home.waterBill.toString()}',
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.waterBill.toString(),
                isRequired: false,
              );
            },
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => OtherExpencesPage()));
            },
            title: const Text('অন্যান্য'),
            leading: const Icon(FontAwesomeIcons.ellipsis),
            trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 18),
          ),
          //? might not be needed
          // OptionTile(
          //   home: home,
          //   isTappable: false,
          //   leadingIcon: Icons.format_list_numbered_rounded,
          //   title: 'তলা',
          //   isInt: true,
          //   subTitle: home.floor.toString(),
          //   validationFunciton: (String? value) {
          //     return Utils.compareValues(
          //       value: value!,
          //       compareWith: home.floor.toString(),
          //     );
          //   },
          // ),
          // OptionTile(
          //   home: home,
          //   isTappable: false,
          //   leadingIcon: Icons.view_column,
          //   title: 'ফ্লোরে ফ্ল্যাট সংখ্যা',
          //   isInt: true,
          //   subTitle: home.flatPerFloor.toString(),
          //   validationFunciton: (String? value) {
          //     return Utils.compareValues(
          //       value: value!,
          //       compareWith: home.flatPerFloor.toString(),
          //     );
          //   },
          // ),
          // const Spacer(),
          const Spacer(),
          DeleteButton(
            action: () => onHomeDeleted(context),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
