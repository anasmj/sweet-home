import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/views/service_charge_page/service_charge_page.dart';

import 'bill_tile.dart';

// ignore: must_be_immutable
class GeneralBillsList extends StatelessWidget {
  GeneralBillsList({super.key, this.home, this.flat});
  Flat? flat;
  Home? home;
  @override
  Widget build(BuildContext context) {
    return flat != null
        ? Column(
            children: [
              BillTile(
                onClick: tap,
                leadingIcon: Icons.home,
                title: 'ভাড়া',
                subTitle: '৳ ${flat!.flatRentAmount.toStringAsFixed(1)}',
                isNumeric: false,
              ),
              BillTile(
                leadingIcon: Icons.gas_meter_outlined,
                title: 'গ্যাস',
                subTitle: '৳ ${flat!.flatGasBill.toStringAsFixed(1)}',
                isNumeric: false,
              ),
              BillTile(
                leadingIcon: FontAwesomeIcons.shower,

                // leadingIcon: Icons.water_drop_outlined,
                title: 'পানি',
                subTitle: '৳ ${flat!.flatWaterBill.toStringAsFixed(1)}',
              ),
              BillTile(
                onClick: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => ServiceChargePage())),
                leadingIcon: FontAwesomeIcons.ellipsis,
                trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 18),
                title: 'অন্যান্য',
                subTitle: '৳ 200',
                isNumeric: false,
              )
            ],
          )
        : Container(
            child: Text('home'),
          );
  }

  void tap() {
    print('tapped');
  }
}
