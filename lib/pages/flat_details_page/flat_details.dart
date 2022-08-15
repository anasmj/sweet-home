import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rent_home/utils/bills.dart';
import '../../models/renter.dart';
import '../app_icons.dart';
import 'transactoin_list_page/transaction_list_page.dart';
import 'monthly_expence_page/monthly_expence_page.dart';
import 'transaction_entry_page/transaction_entry_page.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS

class FlatDetails extends StatelessWidget {
  FlatDetails({required this.renter, super.key});
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);

  List<String> menuTitles = ['লেনদেনসমূহ', 'রিপোর্ট', 'তাগাদা দিন'];

  Renter renter;

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      //initialIndex: 1,
      length: 2,
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
                    case 'লেনদেনসমূহ':
                      Navigator.push(
                        context,
                        PageTransition(
                          //comes from a package
                          child: TransactionListPage(renter: renter),
                          type: PageTransitionType.fade,
                        ),
                      );
                      break;
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
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: MonthlyExpencePage(renter: renter),
            ),
            const EntryPage(),
          ],
        ),
      ),
    );
  }

  ListTile appBarContent(TextTheme appTextTheme) {
    return ListTile(
      title: Text(
        renter.name,
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
                image: AssetImage(AppIcons().takaUrl),
              ),
            ),
            TextSpan(
              text:
                  '${Bill.setRenter(renter: renter).totalBill.toStringAsFixed(1)} \n',
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

  // Widget reportButton() => SizedBox(
  //       width: 100,
  //       child: ElevatedButton(
  //         style: ElevatedButton.styleFrom(),
  //         onPressed: () {},
  //         child: Row(
  //           children: [
  //             SvgPicture.asset(
  //               AppIcons().reportUrl,
  //               height: 18,
  //             ),
  //             const Padding(
  //               padding: EdgeInsets.only(left: 6.0, top: 4),
  //               child: Text('রিপোর্ট'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
}
