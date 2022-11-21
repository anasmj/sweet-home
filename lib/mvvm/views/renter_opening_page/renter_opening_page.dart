import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/record_services.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/components/renter_app_bar.dart';
import 'monthly_expence_page/monthly_expence.dart';
import 'transaction_entry_page/transaction_entry_page.dart';
import 'transactoin_list_page/renter_transaction_list.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS

class RenterOpeningPage extends StatefulWidget {
  const RenterOpeningPage({super.key});

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
    String flatName =
        context.watch<SelectedFlatProvider>().selectedFlat!.flatName;

    String homeId = context.watch<CurrentHomeProvider>().currentHome!.homeId;
    RecordService().getAll(homeId: homeId, flatName: flatName);
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
