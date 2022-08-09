import 'package:flutter/material.dart';
import '../../models/flat_model.dart';
import 'components/appbar_content.dart';
import 'monthly_expence_page/monthly_expence_page.dart';
import 'transaction_page/transaction_page.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS

class FlatDetails extends StatelessWidget {
  FlatDetails({required this.flat, super.key});
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);
  Flat flat;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 30),
              child: AppBarContent(
                renter: flat.renter,
              ),
            ),
            bottom: TabBar(
              labelStyle: _tabBarTextStyle,
              tabs: const [
                Text('মাসিক হিসাব'),
                Text('লেনদেন'),
              ],
            ),
          ),
        ),
        // body: const MonthlyExpencePage(),
        body: const TabBarView(
          children: [
            Center(
              child: MonthlyExpencePage(),
            ),
            TransactionPage(),
          ],
        ),
      ),
    );
  }
}
