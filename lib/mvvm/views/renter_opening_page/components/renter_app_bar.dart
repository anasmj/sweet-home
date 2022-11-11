import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/components/renter_popup_menu.dart';

// ignore: must_be_immutable
class RenterAppBar extends StatelessWidget {
  RenterAppBar({super.key});

  String lastTransactionTime = '';
  final double _tabBarFontSize = 18;
  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    FlatViewModel flatViewModel = context.watch<FlatViewModel>();
    Flat? flat = context.watch<FlatViewModel>().userFlat;
    String? homeId = context.read<CurrentHomeProvider>().currentHome?.homeId;
    double totalDue = flat!.confirmDate != null
        ? flat.renter!.renterDue + flat.monthlyDue
        : flatViewModel.total;

    return StreamBuilder(
      stream: FlatService()
          .selectedFlatSteram(homeId: homeId!, flatId: flat.flatName),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          Flat? flat = snapshot.data as Flat;
          if (flat.renter != null) {
            if (flat.renter!.transactions!.isNotEmpty) {
              lastTransactionTime =
                  Formatter().appDateTime(flat.renter!.transactions!.last.time);
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
                flat.renter!.renterName,
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
