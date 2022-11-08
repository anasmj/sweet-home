import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/components/renter_app_bar.dart';
import 'monthly_expence_page/monthly_expence_page.dart';
import 'transaction_entry_page/transaction_entry_page.dart';
import 'transactoin_list_page/renter_transaction_list.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS

//called from flat list page
// ignore: must_be_immutable
class RenterOpeningPage extends StatelessWidget {
  RenterOpeningPage({super.key});
  // final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);
  final double _appBarHeight = 160;

  List<String> menuTitles = [
    'ফ্ল্যাটের তথ্যাবলী',
    'গ্রাহকের প্রোফাইল',
    'তাগাদা দিন'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset:
            true, //to avoid overflow error while opening keyboard in payer name dialog
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_appBarHeight),
          child: RenterAppBar(),
        ),
        body: const TabBarView(
          children: [
            // SizedBox(),

            MonthlyExpence(),
            TransactionEntryPage(),
            RenterTransactions(),
            // TransactionList(),
            // EmptyContent.getEmptyTransactionPage(),
          ],
        ),
      ),
    );
  }
}
