import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
import 'package:sweet_home/mvvm/views/owner_home/selected_home_info_page/components/option_tile.dart';
import 'package:sweet_home/mvvm/views/service_charge_page/service_charge_page.dart';
import 'package:sweet_home/mvvm/views/owner_home/selected_home_info_page/components/delete_button.dart';
import '../../../../prev/utils/routes.dart';
import '../../../../prev/utils/compare_values.dart';
import '../../../models/home_model.dart';

// ignore: must_be_immutable
class SelectedHomeInfoPage extends StatelessWidget {
  SelectedHomeInfoPage({super.key, required this.home, this.onDeleted});
  VoidCallback? onDeleted;
  Home home;

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
      body: _ui(home, context),
    );
  }

  RefreshIndicator _ui(Home home, BuildContext context) {
    final provider = Provider.of<HomeListViewModel>(context);

    return RefreshIndicator(
      onRefresh: () async {
        await provider.getUserHomes();
      },
      child: ListView(
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
                  MaterialPageRoute(builder: (ctx) => ServiceChargePage()));
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
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          DeleteButton(),
        ],
      ),
    );
  }
}
