import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sweet_home/src/model/home.dart';
import 'package:sweet_home/src/utils/compare_values.dart';
import 'package:sweet_home/src/utils/formatter.dart';

import '../../../components/option.tile/option.tile.dart';

// ignore: must_be_immutable
class HomeInfoPage extends StatelessWidget {
  HomeInfoPage({super.key, required this.home, this.onDeleted});
  VoidCallback? onDeleted;
  Home home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home.homeName'),
        centerTitle: true,
        actions: const [
          // IconButton(
          //   onPressed: () => AppRoute.newHomeStepper(context: context),
          //   icon: const Icon(Icons.add),
          // ),
        ],
      ),
      body: _ui(home, context),
    );
  }

  Widget _ui(Home home, BuildContext context) {
    // final viewModel = context.watch<HomeListViewModel>();

    return RefreshIndicator(
      onRefresh: () async {
        // await context.read<HomeListViewModel>().getUserHomes();
      },
      child: ListView(
        children: [
          OptionTile(
            // homeListViewModel: viewModel,
            // home: home,
            leadingIcon: Icons.home_filled,
            sheetTitle: 'বাড়ীর নাম',
            textFieldContent: home.homeName,
            subTitle: 'home.homeName',
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.homeName.toString(),
              );
            },
            isNumeric: false,
          ),
          OptionTile(
            // home: home,
            leadingIcon: Icons.money_rounded,
            isDouble: true,
            sheetTitle: 'ভাড়া',
            textFieldContent: home.rentAmount,
            subTitle: Formatter.toBn(value: home.rentAmount),
            // subTitle: '৳ ${home.rentAmount.toStringAsFixed(1)}',
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.rentAmount,
              );
            },
          ),

          OptionTile(
            // home: home,
            leadingIcon: Icons.pin_drop,
            sheetTitle: 'ঠিকানা',
            subTitle: 'home.location',
            textFieldContent: home.location,
            isNumeric: false,
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.location.toString(),
                // isRequired: false,
              );
            },
          ),

          OptionTile(
            // home: home,
            leadingIcon: Icons.gas_meter_outlined,
            sheetTitle: 'গ্যাস',
            isDouble: true,
            subTitle: Formatter.toBn(value: home.gasBill),
            textFieldContent: home.gasBill,
            // subTitle: '৳ ${home.gasBill.toString()}',
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.gasBill.toString(),
                // isRequired: false,
              );
            },
          ),
          OptionTile(
            // home: home,
            leadingIcon: FontAwesomeIcons.shower,
            sheetTitle: 'পানি',
            isDouble: true,
            subTitle: Formatter.toBn(value: home.waterBill),
            textFieldContent: home.waterBill,
            validationFunciton: (String? value) {
              return Utils.compareValues(
                value: value!,
                compareWith: home.waterBill.toString(),
                // isRequired: false,
              );
            },
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (ctx) => const HomeServiceChargePage(),
              //   ),
              // );
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
          // DeleteButton(honeInfoPageContext: context),
        ],
      ),
    );
  }
}
