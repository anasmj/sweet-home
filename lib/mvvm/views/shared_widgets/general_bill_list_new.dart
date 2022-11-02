import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/flat_info_page/service_charge/flat_service_charge_page.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/option_tile.dart';
import 'package:sweet_home/prev/utils/compare_values.dart';

// ignore: must_be_immutable
class GeneralBillsListNew extends StatelessWidget {
  GeneralBillsListNew({super.key, this.home, this.flat, required this.scope});
  Scope scope;

  Home? home;
  Flat? flat;
  final String _rent = 'ভাড়া', _gas = 'গ্যাস', _water = 'পানি';

  @override
  Widget build(BuildContext context) {
    FlatViewModel flatViewModel = context.watch<FlatViewModel>();
    //? USE IT IN CASE YOU WANT TO ALLOW USER TO MAKE SERVICE CHARGE FOR INDIVIDUAL FLAT
    if (home != null || flat != null) {
      return flat != null
          ? Column(
              children: [
                OptionTile(
                  flatViewModel: flatViewModel,
                  leadingIcon: Icons.money_rounded,
                  isDouble: true,
                  sheetTitle: _rent,
                  textFieldContent:
                      flat != null ? flat!.flatRentAmount : home!.rentAmount,
                  subTitle: Formatter.toBn(
                      value: flat != null
                          ? flat!.flatRentAmount
                          : home!.rentAmount),
                  // subTitle: '৳ ${home.rentAmount.toStringAsFixed(1)}',
                  validationFunciton: (String? value) {
                    return Utils.compareValues(
                      value: value!,
                      compareWith: flat != null
                          ? flat!.flatRentAmount
                          : home!.rentAmount,
                    );
                  },
                ),
                OptionTile(
                  flatViewModel: flatViewModel,
                  leadingIcon: Icons.gas_meter_outlined,
                  sheetTitle: _gas,
                  isDouble: true,
                  subTitle: Formatter.toBn(
                      value: flat != null ? flat!.flatGasBill : home!.gasBill),
                  textFieldContent:
                      flat != null ? flat!.flatGasBill : home!.gasBill,
                  validationFunciton: (String? value) {
                    return Utils.compareValues(
                      value: value!,
                      compareWith: flat != null
                          ? flat!.flatGasBill.toString()
                          : home!.gasBill.toString(),
                    );
                  },
                ),
                OptionTile(
                  flatViewModel: flatViewModel,
                  leadingIcon: FontAwesomeIcons.shower,
                  sheetTitle: _water,
                  isDouble: true,
                  subTitle: Formatter.toBn(value: flat!.flatWaterBill),
                  textFieldContent: flat!.flatWaterBill,
                  validationFunciton: (String? value) {
                    return Utils.compareValues(
                      value: value!,
                      compareWith: flat!.flatWaterBill.toString(),
                    );
                  },
                ),
                ListTile(
                  onTap: () async {
                    //?in FlatServicePage user are not allowd to change any service charge

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const FlatServiceChargePage(),
                      ),
                    );
                  },
                  leading: const Icon(FontAwesomeIcons.ellipsis),
                  trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 18),
                  title: const Text('অন্যান্য'),
                  // subtitle: const Text('৳ 200'),
                ),
              ],
            )
          : const Center(child: Text('No Flat'));
    } else {
      return const SizedBox();
    }
  }
}
