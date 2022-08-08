import 'package:flutter/material.dart';
import 'components/appbar_content.dart';
import 'components/monthly_details_page.dart';
import 'components/transaction_page.dart';

class FlatDetails extends StatelessWidget {
  const FlatDetails({super.key});

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
              labelStyle:
                  Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18),
              tabs: const [
                Text('লেনদেন'),
                Text('মাসিক হিসাব'),
              ],
            ),
          ),
        ),
        // body: const MonthlyDetailsPage(),
        body: const TabBarView(
          children: [
            TransactionPage(),
            Center(
              child: MonthlyDetailsPage(),
            ),
          ],
        ),
      ),
    );
  }
}
