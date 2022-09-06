//* THIS IS FOLLOWED BY DESIGNE

import 'package:flutter/material.dart';
import 'package:sweet_home/view/app_pages/pending_page/pending_page.dart';
import 'package:sweet_home/view/resources/app_icons.dart';
import '../current_month_page/current_month_details.dart';
import '../flats_page/flat_list_page.dart';
import 'components/custom_appbar.dart';
import 'components/drawer.dart';

class HomePageV2 extends StatefulWidget {
  HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  final double _appIconHeight = 20;
  final double _appIconWidth = 20;
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);
  int _currentTabIndex = 0;
  final double _appBarHeight = 280;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (newIndex) {
          switch (newIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageV2(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FlatListPage(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PendingPage(),
                ),
              );
              break;
          }
          setState(() => _currentTabIndex = newIndex);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Current Month'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Flats'),
          BottomNavigationBarItem(icon: Icon(Icons.pending), label: 'pendings'),
        ],
      ),
      body: CustomScrollView(
        controller: ScrollController(),
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverAppbarDelegate(expandedHeight: _appBarHeight),
            pinned: false,
          ),
          SliverToBoxAdapter(
            child: CurrentMonthPage(),
          ),
        ],
      ),
    );
  }

  Widget getTakaIcon(String iconUrl) => SizedBox(
        height: _appIconHeight,
        width: _appIconWidth,
        child: Image(
          image: AssetImage(AppIcons.takaUrl),
        ),
      );

  //TODO: make it fancy by puttin comma between digitsz
  Widget getAmountText(int amount) => Text(' ${amount.toString()} /-');
}
