//* THIS IS FOLLOWED BY DESIGNE
import 'package:flutter/material.dart';
import 'package:rent_home/screens/home_screen/tab_bar_pages/current_month_details/current_month_details.dart';
import 'package:rent_home/screens/home_screen/tab_bar_pages/dues.dart';
import 'package:rent_home/screens/home_screen/tab_bar_pages/expences.dart';
import 'package:rent_home/screens/home_screen/tab_bar_pages/renters.dart';
import '../app_icons.dart';
import '../../utils/date_and_time.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final double _appIconHeight = 20;
  final double _appIconWidth = 20;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: const Drawer(),
      body: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  //floating: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 10),
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: '${DateAndTime().currentDateAndMonth()} \n',
                              style: textTheme.headline6!.copyWith(
                                  color: Colors.black.withOpacity(0.8)),
                            ),
                            TextSpan(
                              text: DateAndTime().weekDay(),
                              style: textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  //pinned: true,
                  title: Text('আহসান মঞ্জিল ',
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: textTheme.headline6),
                  centerTitle: true,
                  bottom: TabBar(
                    tabs: [
                      Text(
                        'চলতি মাস',
                        style: textTheme.subtitle1,
                      ),
                      Text(
                        'বকেয়া',
                        style: textTheme.subtitle1,
                      ),
                      Text(
                        'সব গ্রাহক',
                        style: textTheme.subtitle1,
                      ),
                      Text(
                        'খরচ',
                        style: textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                CurrentMonthDetails(),
                Dues(),
                Renters(),
                Expences(),
              ],
            )),
      ),
    );
  }

  Widget getIcon(String iconUrl) => SizedBox(
        height: _appIconHeight,
        width: _appIconWidth,
        child: Image(
          image: AssetImage(AppIcons().takaUrl),
        ),
      );

  //TODO: make it fancy by puttin comma between digits
  Widget getAmountText(int amount) => Text(' ${amount.toString()} /-');
}
