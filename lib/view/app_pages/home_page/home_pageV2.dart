//* THIS IS FOLLOWED BY DESIGNE

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/models/month_details.dart';
import 'package:sweet_home/view/app_pages/pending_page/pending_page.dart';
import 'package:sweet_home/view/resources/app_icons.dart';
import '../../../providers/home_provider.dart';
import '../../app_widgets.dart';
import '../current_month_page/current_month_details.dart';
import '../flats_page/components/customize_button.dart';
import '../flats_page/components/flat_container.dart';
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
  int _currentTabIndex = 0;
  final double _appBarHeight = 280;
  bool isInitialState = false;
  final int _currentMonthPageIndex = 0;
  final int _flatListPageIndex = 1;
  final int _pendingPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (newIndex) {
          setState(() => _currentTabIndex = newIndex);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'চলতি মাস '),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ফ্ল্যাটগুলি'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pending), label: 'বকেয়া সমূহ'),
        ],
      ),
      body: getUserSelectedPage(_currentTabIndex),
    );
  }

  Widget getUserSelectedPage(int selectedIndex) {
    if (selectedIndex == 0) {
      return CustomScrollView(
        controller: ScrollController(),
        slivers: [
          SliverPersistentHeader(
            //APP BAR
            delegate: CustomSliverAppbarDelegate(expandedHeight: _appBarHeight),
            pinned: false,
          ),
          SliverToBoxAdapter(
            child: CurrentMonthPage(),
          ),
          // child: CurrentMonthPage(),
        ],
      );
    }
    if (selectedIndex == _currentMonthPageIndex) return FlatListPage();
    if (selectedIndex == _flatListPageIndex) return FlatListPage();
    if (selectedIndex == _pendingPageIndex) return PendingPage();
    return const SizedBox();
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
