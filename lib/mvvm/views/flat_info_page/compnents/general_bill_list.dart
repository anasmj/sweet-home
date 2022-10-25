import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';
import 'package:sweet_home/mvvm/views/flat_info_page/flat_service_charge_page/flat_service_charge_page.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/option_tile.dart';
import 'package:sweet_home/prev/utils/compare_values.dart';

// ignore: must_be_immutable
class GeneralBillsList extends StatelessWidget {
  GeneralBillsList({super.key, this.home, this.flat});
  Flat? flat;
  Home? home;
  final String _rent = 'ভাড়া', _gas = 'গ্যাস', _water = 'পানি';

  @override
  Widget build(BuildContext context) {
    final flatViewModel = Provider.of<FlatListViewModel>(context);

    //? USE IT IN CASE YOU WANT TO ALLOW USER TO MAKE SERVICE CHARGE FOR INDIVIDUAL FLAT

    return flat != null
        ? Column(
            children: [
              OptionTile(
                flatListViewModel: flatViewModel,
                // home: home,
                leadingIcon: Icons.money_rounded,
                isDouble: true,
                sheetTitle: _rent,
                textFieldContent: flat!.flatRentAmount,
                subTitle: Formatter.toBn(value: flat!.flatRentAmount),
                // subTitle: '৳ ${home.rentAmount.toStringAsFixed(1)}',
                validationFunciton: (String? value) {
                  return Utils.compareValues(
                    value: value!,
                    compareWith: flat!.flatRentAmount,
                  );
                },
              ),
              OptionTile(
                flatListViewModel: flatViewModel,
                leadingIcon: Icons.gas_meter_outlined,
                sheetTitle: _gas,
                isDouble: true,
                subTitle: Formatter.toBn(value: flat!.flatGasBill),
                textFieldContent: flat!.flatGasBill,
                validationFunciton: (String? value) {
                  return Utils.compareValues(
                    value: value!,
                    compareWith: flat!.flatGasBill.toString(),
                  );
                },
              ),
              OptionTile(
                flatListViewModel: flatViewModel,
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
        : const Text('No Flat');
  }
}
