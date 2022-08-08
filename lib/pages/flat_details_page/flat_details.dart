import 'package:flutter/material.dart';
import 'components/appbar_content.dart';
import 'components/monthly_details_page.dart';
import 'components/transaction_page.dart';

class FlatDetails extends StatelessWidget {
  FlatDetails({super.key});
  final TextStyle _tabBarTextStyle = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            flexibleSpace: const Padding(
              padding: EdgeInsets.only(top: 50.0, left: 30),
              child: AppBarContent(),
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
        // body: const MonthlyDetailsPage(),
        body: const TabBarView(
          children: [
            Center(
              child: MonthlyDetailsPage(),
            ),
            TransactionPage(),
          ],
        ),
      ),
    );
  }
}
