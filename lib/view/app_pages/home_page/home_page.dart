//* THIS IS FOLLOWED BY DESIGNE
import 'package:flutter/material.dart';
import 'package:sweet_home/utils/routes.dart';
import 'package:sweet_home/view/resources/app_icons.dart';
import '../current_month_page/current_month_details.dart';
import '../flats_page/flat_list_page.dart';
import '../pending_page/pending_page.dart';
import 'components/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final double _appIconHeight = 20;
  final double _appIconWidth = 20;
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        AppRoute.getCurrentHomeInfo(context);
                      },
                      icon: const Icon(Icons.home),
                    )
                  ],
                  //pinned: true,

                  centerTitle: true,
                  //TAB BAR
                  bottom: TabBar(
                    indicatorColor: Colors.white,
                    indicatorWeight: 5,
                    tabs: getAppBarTabs(),
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

  List<Text> getAppBarTabs() => [
        Text('চলতি মাস', style: _tabBarTextStyle),
        Text('ফ্ল্যাটগুলি', style: _tabBarTextStyle),
        Text('বকেয়া', style: _tabBarTextStyle)
      ];
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
