import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/views/flat_info_pages/sub_pages/flat_info/compnents/others_page.dart';

import 'bill_tile.dart';

class GeneralBillsList extends StatelessWidget {
  const GeneralBillsList({super.key});

  @override
  Widget build(BuildContext context) {
    Flat? flat = Provider.of<SelectedFlatProvider>(context).selectedFlat;

    return flat == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              BillTile(
                onClick: tap,
                leadingIcon: Icons.home,
                title: 'ভাড়া',
                subTitle: '৳ ${flat.flatRentAmount.toStringAsFixed(1)}',
                isNumeric: false,
              ),
              BillTile(
                leadingIcon: Icons.gas_meter_outlined,
                title: 'গ্যাস',
                subTitle: '৳ ${flat.flatGasBill.toStringAsFixed(1)}',
                isNumeric: false,
              ),
              BillTile(
                leadingIcon: FontAwesomeIcons.shower,

                // leadingIcon: Icons.water_drop_outlined,
                title: 'পানি',
                subTitle: '৳ ${flat.flatWaterBill.toStringAsFixed(1)}',
              ),
              BillTile(
                onClick: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => OtherExpences())),
                leadingIcon: FontAwesomeIcons.ellipsis,
                trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 18),
                title: 'অন্যান্য',
                subTitle: '৳ 200',
                isNumeric: false,
              )
            ],
          );
  }

  void tap() {
    print('tapped');
  }
}
