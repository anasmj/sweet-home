import 'package:flutter/material.dart';
import 'package:sweet_home/utils/calculate_bills.dart';
import 'package:sweet_home/view/app_pages/empty_pages/empty_tarnsaction.dart';
import 'package:sweet_home/view/app_pages/renter_profile_page.dart';
import '../../../models/renter.dart';
import 'package:sweet_home/view/resources/app_icons.dart';
import 'transactoin_list_page/transaction_list_page.dart';
import 'monthly_expence_page/monthly_expence_page.dart';
import 'transaction_entry_page/transaction_entry_page.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS

//called from flat list page
// ignore: must_be_immutable
class RenterOpeningPage extends StatelessWidget {
  RenterOpeningPage({required this.renter, super.key});
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);

  List<String> menuTitles = ['গ্রাহকের প্রোফাইল', 'রিপোর্ট', 'তাগাদা দিন'];

  Renter renter;

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            elevation: 0.0,
            actions: [
              renterPopupMenu(context),
            ],
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 80),
              child: appBarContent(appTextTheme),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelStyle: _tabBarTextStyle,
              tabs: const [
                Text('মাসিক হিসাব'),
                Text('হিসাব এন্ট্রি'),
                Text('লেনদেনসমূহ'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // const Center(child: Text('Monthly Expence')),
            MonthlyExpencePage(renter: renter),
            const EntryPage(),
            // TransactionListPage(renter: renter),
            EmptyContent.getEmptyTransactionPage(),
          ],
        ),
      ),
    );
  }

  PopupMenuButton<String> renterPopupMenu(BuildContext context) {
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
                          renter: renter,
                        )));
            break;
          case 'রিপোর্ট':
            print(value);
            break;
          case 'তাগাদা দিন':
            break;
        }
      },
    );
  }

  ListTile appBarContent(TextTheme appTextTheme) {
    return ListTile(
      title: Text(
        renter.renterName,
        style: appTextTheme.headline5!,
        maxLines: 1,
        overflow: TextOverflow.fade,
        // softWrap: true,
      ),
      subtitle: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'পাবো ', style: appTextTheme.subtitle1),
            WidgetSpan(
              child: Image(
                height: 18,
                width: 18,
                color: Colors.red[900],
                image: AssetImage(AppIcons.takaUrl),
              ),
            ),
            TextSpan(
              text: ' 23412\n',
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
