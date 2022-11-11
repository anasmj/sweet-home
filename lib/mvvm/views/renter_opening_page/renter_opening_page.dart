import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/record.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/components/renter_app_bar.dart';
import 'monthly_expence_page/monthly_expence.dart';
import 'monthly_expence_page/monthly_expence_new.dart';
import 'transaction_entry_page/transaction_entry_page.dart';
import 'transactoin_list_page/renter_transaction_list.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS

//called from flat list page
// ignore: must_be_immutable
class RenterOpeningPage extends StatefulWidget {
  RenterOpeningPage({super.key});

  @override
  State<RenterOpeningPage> createState() => _RenterOpeningPageState();
}

class _RenterOpeningPageState extends State<RenterOpeningPage> {
  // final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);
  final double _appBarHeight = 160;
  Response? response;

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
        body: TabBarView(
          children: [
            // SizedBox(),

            // MonthlyExpence(),
            MonthlyExpenceNew(),
            const TransactionEntryPage(),
            const RenterTransactions(),
            // TransactionList(),
            // EmptyContent.getEmptyTransactionPage(),
          ],
        ),
      ),
    );
  }
}
