import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/renter.dart';
import '../resources/app_icons.dart';
import 'monthly_expence_page/monthly_expence_page.dart';
import 'transaction_entry_page/transaction_entry_page.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS
//!bckup
//called from flat list page
// ignore: must_be_immutable
class FlatDetails extends StatelessWidget {
  FlatDetails({required this.renter, super.key});
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);

  List<String> menuTitles = ['রিপোর্ট', 'তাগাদা দিন'];

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
            actions: [
              PopupMenuButton(
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
                    case 'রিপোর্ট':
                      break;
                    case 'তাগাদা দিন':
                      break;
                  }
                },
              ),
            ],
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 70),
              child: appBarContent(appTextTheme),
            ),
            bottom: TabBar(
              labelStyle: _tabBarTextStyle,
              tabs: const [
                Text('মাসিক হিসাব'),
                Text('হিসাব এন্ট্রি'),
                Text('লেনদেনসমূহ'),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: MonthlyExpencePage(),
            ),
            EntryPage(),
            // TransactionListPage(renter: renter),
          ],
        ),
      ),
    );
  }

  ListTile appBarContent(TextTheme appTextTheme) {
    return ListTile(
      title: Text(
        renter.renterName,
        style: appTextTheme.headlineSmall!,
        maxLines: 1,
        overflow: TextOverflow.fade,
        // softWrap: true,
      ),
      subtitle: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'পাবো ', style: appTextTheme.titleMedium),
            WidgetSpan(
              child: Image(
                height: 18,
                width: 18,
                color: Colors.red[900],
                image: AssetImage(AppIcons.takaUrl),
              ),
            ),
            TextSpan(
              text: '23412',
              // '${CalculateBill.setRenter(renter: renter).totalBill.toStringAsFixed(1)} \n',
              style: appTextTheme.titleLarge!.copyWith(
                  color: Colors.red[900], fontWeight: FontWeight.w600),
            ),
            TextSpan(
                text: 'সর্বশেষ লেনদেনঃ 12 Aug, 22',
                style: appTextTheme.bodySmall!.copyWith(fontSize: 14)),
          ],
        ),
      ),
      //trailing: reportButton(),
    );
  }
}
