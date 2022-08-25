//* THIS IS FOLLOWED BY DESIGNE
import 'package:flutter/material.dart';
import 'package:sweet_home/views/styling/app_icons.dart';
import '../current_month_page/current_month_details.dart';
import '../flats_page/flat_list_page.dart';
import '../pending_page/pending_page.dart';
import 'components/change_theme_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final double _appIconHeight = 20;
  final double _appIconWidth = 20;
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: const Drawer(),
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  //pinned: true,

                  // APP BAR
                  title: const Text(
                    'আহসান মঞ্জিল ',
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(fontSize: 20),
                  ),
                  actions: const [
                    ChangeThemeButton(),
                  ],
                  centerTitle: true,
                  //TAB BAR
                  bottom: TabBar(
                    indicatorColor: Colors.white,
                    indicatorWeight: 5,
                    tabs: [
                      Text(
                        'চলতি মাস',
                        style: _tabBarTextStyle,
                      ),
                      Text(
                        'ফ্ল্যাটগুলি',
                        style: _tabBarTextStyle,
                      ),
                      Text(
                        'বকেয়া',
                        style: _tabBarTextStyle,
                      ),
                      // Text(
                      //   'সকল গ্রাহক',
                      //   style: textTheme.subtitle1,
                      // ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                CurrentMonthPage(),
                FlatListPage(),
                PendingPage(),
                //Expences(),
              ],
            )),
      ),
    );
  }

  Widget getIcon(String iconUrl) => SizedBox(
        height: _appIconHeight,
        width: _appIconWidth,
        child: Image(
          image: AssetImage(AppIcons.takaUrl),
        ),
      );

  //TODO: make it fancy by puttin comma between digitsz
  Widget getAmountText(int amount) => Text(' ${amount.toString()} /-');
}
