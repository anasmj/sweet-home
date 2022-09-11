import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/view/app_pages/pending_page/pending_page.dart';
import 'package:sweet_home/view/resources/app_icons.dart';
import '../../../models/home_model.dart';
import '../../../services/database_service/home_crud.dart';
import '../current_month_page/current_month_details.dart';
import '../flats_page/flat_list_page.dart';
import 'components/custom_appbar.dart';
import 'components/drawer.dart';

class AppHomePage extends StatefulWidget {
  AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePage();
}

class _AppHomePage extends State<AppHomePage> {
  final double _appIconHeight = 20;
  final double _appIconWidth = 20;
  int _currentTabIndex = 0;
  final double _appBarHeight = 280;
  bool isInitialState = false;
  final int _currentMonthPageIndex = 0;
  final int _flatListPageIndex = 1;
  final int _pendingPageIndex = 2;

  //! ALWAYS SETS THE FIRST HOME AS CURRENT HOME TO USER AFTER LOGIN
  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider providerRead = context.watch<CurrentHomeProvider>();

    return FutureBuilder<List<Home>>(
      future: HomeCrud().getAllHome(),
      builder: (context, AsyncSnapshot<List<Home>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return showWaitingIndicator(context);
        }
        if (!snapshot.hasData) {}
        List<Home>? homes = snapshot.data;
        if (homes != null) {
          if (homes.isNotEmpty) {
            providerRead.setCurrentHome(homes.first);
          }
        }
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'ফ্ল্যাটগুলি'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pending), label: 'বকেয়া সমূহ'),
            ],
          ),
          body: getUserSelectedPage(_currentTabIndex),
        );
      },
    );
  }

  Widget showWaitingIndicator(context) => const Scaffold(
        body: Center(
            child: Text(
          'Initializing App..',
          style: TextStyle(fontSize: 18),
        )),
      );

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
