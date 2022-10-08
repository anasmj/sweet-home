import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/components/renter_app_bar.dart';
import '../../../../mvvm/models/flat_model.dart';
import 'monthly_expence_page/monthly_expence_page.dart';
import 'transaction_entry_page/transaction_entry_page.dart';

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
    Flat? flat = context.watch<SelectedFlatVuewModel>().selectedFlat;

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, //to avoid overflow error while opening keyboard in payer name dialog
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_appBarHeight),
          child:
              flat != null ? RenterAppBar(flat: flat) : const SizedBox.shrink(),
        ),
        body: WillPopScope(
          onWillPop: () async {
            //re render flat list
            return true;
          },
          child: const TabBarView(
            children: [
              MonthlyExpencePage(),
              EntryPage(),
              SizedBox(),
              // TransactionList(),
              // EmptyContent.getEmptyTransactionPage(),
            ],
          ),
        ),
      ),
    );
  }
}
