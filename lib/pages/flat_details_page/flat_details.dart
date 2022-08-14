import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../models/renter.dart';
import '../app_icons.dart';
import 'monthly_expence_page/monthly_expence_page.dart';
import 'transaction_page/transaction_page.dart';

//*SHOWS SUMMARY OF A USER IN APP BAR
//*PROVIDES TWO TAB BAR 1.MONTHLY EXPENCE, 2.TRANSACTIONS

class FlatDetails extends StatelessWidget {
  FlatDetails({required this.renter, super.key});
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);

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
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 70),
              child: appBarContent(appTextTheme),
            ),
            bottom: TabBar(
              labelStyle: _tabBarTextStyle,
              tabs: const [
                Text('মাসিক হিসাব'),
                Text('লেনদেন'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: MonthlyExpencePage(renter: renter),
            ),
            const TransactionPage(),
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
              text: '10400\n', //TODO: fix
              style: appTextTheme.headline6!.copyWith(
                  color: Colors.red[900], fontWeight: FontWeight.w600),
            ),
            TextSpan(
                text: 'সর্বশেষ লেনদেনঃ 12 Aug, 22', //TODO: fix
                style: appTextTheme.caption!.copyWith(fontSize: 14)),
          ],
        ),
      ),
      trailing: reportButton(),
    );
  }

  Widget reportButton() => SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {},
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons().reportUrl,
                height: 18,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 6.0, top: 4),
                child: Text('রিপোর্ট'),
              ),
            ],
          ),
        ),
      );
}
