import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/api/record_services.dart';
import 'package:sweet_home/src/model/response.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart';

import '../flats/provider/selected.flat.provider.dart';
import 'components/renter_app_bar.dart';
import 'monthly_expence_page/monthly_expence.dart';
import 'transaction_entry_page/transaction_entry_page.dart';
import 'transactoin_list_page/renter_transaction_list.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS

class RenterOpeningPage extends ConsumerStatefulWidget {
  const RenterOpeningPage({super.key});

  @override
  ConsumerState<RenterOpeningPage> createState() => _RenterOpeningPageState();
}

class _RenterOpeningPageState extends ConsumerState<RenterOpeningPage> {
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
    RecordService().getAll(
      homeId: ref.watch(selectedHomeProvider)!.homeId!,
      flatName: ref.watch(selectedFlatProvider)!.flatName,
    );
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
