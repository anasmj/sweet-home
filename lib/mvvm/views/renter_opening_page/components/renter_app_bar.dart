import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/providers/bills_provider.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/components/renter_popup_menu.dart';

// ignore: must_be_immutable
class RenterAppBar extends StatelessWidget {
  RenterAppBar({required this.flat, super.key});
  Flat flat;
  final double _tabBarFontSize = 18;
  @override
  Widget build(BuildContext context) {
    double totalBill = context.watch<BillsProvider>().totalBill ?? 0;
    TextTheme appTextTheme = Theme.of(context).textTheme;
    return AppBar(
      elevation: 0.0,
      actions: [
        RenterPopUpMenu(flat: flat),
      ],
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 80),
        child: ListTile(
          title: Text(
            flat.renter!.renterName,
            style: Theme.of(context).textTheme.headlineSmall,
            maxLines: 1,
            overflow: TextOverflow.fade,
            // softWrap: true,
          ),
          subtitle: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'পাবো  ', style: appTextTheme.titleMedium),
                // AppWidget.taka,
                TextSpan(
                  text: '৳${totalBill.toStringAsFixed(1)} \n',
                  // '${CalculateBill.setRenter(renter: renter).totalBill.toStringAsFixed(1)} \n',
                  style: appTextTheme.headlineSmall!.copyWith(
                      color: Colors.red[900], fontWeight: FontWeight.w600),
                ),
                TextSpan(
                    text: 'সর্বশেষ লেনদেনঃ 12 Aug, 22', //TODO: fix
                    style: appTextTheme.bodySmall!.copyWith(fontSize: 14)),
              ],
            ),
          ),
          //trailing: reportButton(),
        ),
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelStyle: TextStyle(fontSize: _tabBarFontSize),
        tabs: const [
          Tab(text: 'মাসিক হিসাব'),
          Tab(text: 'হিসাব এন্ট্রি'),
          Tab(text: 'লেনদেনসমূহ'),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable

