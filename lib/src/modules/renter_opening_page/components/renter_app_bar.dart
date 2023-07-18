import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/api/flat_services.dart';
import 'package:sweet_home/src/extensions/extensions.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/modules/flats/provider/selected.flat.provider.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart';
import 'package:sweet_home/src/utils/formatter.dart';

import 'renter_popup_menu.dart';

// ignore: must_be_immutable
class RenterAppBar extends ConsumerWidget {
  RenterAppBar({super.key});

  String lastTransactionTime = '';
  final double _tabBarFontSize = 18;
  @override
  Widget build(BuildContext context, ref) {
    TextTheme appTextTheme = Theme.of(context).textTheme;

    Flat? flat = ref.watch(selectedFlatProvider);
    String? homeId = ref.watch(selectedHomeProvider)?.homeId;

    const totalDue = 3;
    if (flat == null) return emptyWidget;
    return StreamBuilder(
      stream: FlatService()
          .selectedFlatSteram(homeId: homeId!, flatId: flat.flatName),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          Flat? flat = snapshot.data as Flat;
          if (flat.renter != null) {
            if (flat.transactions != null) {
              lastTransactionTime =
                  Formatter().appDateTime(flat.transactions!.last.time);
            }
          }
        }
        return AppBar(
          elevation: 0.0,
          actions: [
            RenterPopUpMenu(flat: flat),
          ],
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 80),
            child: ListTile(
              title: Text(
                flat.renter?.renterName ?? '',
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
                overflow: TextOverflow.fade,
                // softWrap: true,
              ),
              subtitle: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: totalDue < 0 ? ' দেবো ' : ' পাবো  ',
                        style: appTextTheme.titleMedium),
                    // AppWidget.taka,
                    TextSpan(
                      text: '${Formatter.toBn(value: totalDue.abs())}\n',

                      // '${Formatter.toBn(value: dueAmount + totalBill)}\n',
                      style: appTextTheme.headlineSmall!.copyWith(
                          color: totalDue <= 0
                              ? Colors.green[900]
                              : Colors.red[900],
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                        text: 'সর্বশেষঃ $lastTransactionTime',
                        style: appTextTheme.bodySmall!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              // trailing: reportButton(),
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
      }),
    );
  }
}
