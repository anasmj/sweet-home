import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/prev/view/screens/renter_opening_page/transactoin_list_page/transaction_list_page.dart';

import '../../../models/flat_model.dart';

import '../../../providers/bills_provider.dart';
import '../../../providers/flat_info_provider.dart';
import '../../app_widgets.dart';
import '../flat_info_pages/single_flat_info_page.dart';
import '../profile_pages/renter_profile_page.dart';
import 'monthly_expence_page/monthly_expence_page.dart';
import 'transaction_entry_page/transaction_entry_page.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS

//called from flat list page
// ignore: must_be_immutable
class RenterOpeningPage extends StatelessWidget {
  RenterOpeningPage({super.key});
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);

  List<String> menuTitles = [
    'ফ্ল্যাটের তথ্যাবলী',
    'গ্রাহকের প্রোফাইল',
    'তাগাদা দিন'
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    Flat? flat = context.watch<SelectedFlatProvider>().selectedFlat;
    final billProvider = Provider.of<BillsProvider>(context);

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, //to avoid overflow error while opening keyboard in payer name dialog
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(160),
          child: AppBar(
            elevation: 0.0,
            actions: [
              renterPopupMenu(context),
            ],
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 80),
              child: appBarContent(context, appTextTheme, flat!),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelStyle: _tabBarTextStyle,
              tabs: const [
                Tab(text: 'মাসিক হিসাব'),
                Tab(text: 'হিসাব এন্ট্রি'),
                Tab(text: 'লেনদেনসমূহ'),
              ],
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            //todo: this may cause a bug
            return true;
          },
          child: const TabBarView(
            children: [
              // const Center(child: Text('Monthly Expence')),
              MonthlyExpencePage(),
              EntryPage(),
              TransactionList(),
              // EmptyContent.getEmptyTransactionPage(),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton<String> renterPopupMenu(BuildContext context) {
    Flat? flat = context.watch<SelectedFlatProvider>().selectedFlat;
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return menuTitles
            .map((title) => PopupMenuItem(
                  value: title,
                  child: Text(title),
                ))
            .toList();
      },
      onSelected: (value) {
        switch (value) {
          case 'গ্রাহকের প্রোফাইল':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RenterProfile(
                  renter: flat!.renter!,
                ),
              ),
            );
            break;
          case 'ফ্ল্যাটের তথ্যাবলী':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SingleFlatInfo(),
              ),
            );

            break;
          case 'তাগাদা দিন':
            break;
        }
      },
    );
  }

  ListTile appBarContent(
      BuildContext context, TextTheme appTextTheme, Flat flat) {
    double totalBill = context.watch<BillsProvider>().totalBill ?? 0;
    return ListTile(
      title: Text(
        flat.renter!.renterName,
        style: appTextTheme.headline5!,
        maxLines: 1,
        overflow: TextOverflow.fade,
        // softWrap: true,
      ),
      subtitle: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'পাবো  ', style: appTextTheme.subtitle1),
            AppWidget.taka,
            TextSpan(
              text: ' ${totalBill.toStringAsFixed(1)} \n',
              // '${CalculateBill.setRenter(renter: renter).totalBill.toStringAsFixed(1)} \n',
              style: appTextTheme.headline6!.copyWith(
                  color: Colors.red[900], fontWeight: FontWeight.w600),
            ),
            TextSpan(
                text: 'সর্বশেষ লেনদেনঃ 12 Aug, 22', //TODO: fix
                style: appTextTheme.caption!.copyWith(fontSize: 14)),
          ],
        ),
      ),
      //trailing: reportButton(),
    );
  }
}
