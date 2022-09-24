import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/view/screens/pending_page/pending_page.dart';
import 'package:sweet_home/view/resources/app_icons.dart';
import '../../../models/home_model.dart';
import '../../../services/home_services.dart';
import '../../../view_models/flat_list_viewmodel.dart';
import '../current_month_page/current_month_details.dart';
import '../flats_page/home_flats.dart';
import '../waiting_pages/searching_for_home.dart';
import 'components/custom_appbar.dart';
import 'components/drawer.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePage();
}

class _AppHomePage extends State<AppHomePage> {
  final double _appIconHeight = 20;
  final double _appIconWidth = 20;
  int _currentTabIndex = 1;
  final double _appBarHeight = 280;
  bool isInitialState = false;

  final int _currentMonthPageIndex = 0;
  final int _flatListPageIndex = 1;
  final int _pendingPageIndex = 2;

  //! SETS THE FIRST HOME AS CURRENT HOME IF NO HOME IS SELECTED PREVIOUSLY
  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider providerRead = context.watch<CurrentHomeProvider>();

    return providerRead.currentHome == null
        ? FutureBuilder<List<Home>>(
            //select a home if any
            future: HomeCrud().getAllHome(),
            builder: (context, AsyncSnapshot<List<Home>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SearchingForHome();
              }
              if (!snapshot.hasData) {}
              List<Home>? homes = snapshot.data;
              if (homes != null) {
                if (homes.isNotEmpty) {
                  providerRead.setCurrentHome(homes.first);
                }
              }
              return showAppHomePage();
            },
          )
        //home is already selected by user
        : showAppHomePage();
  }

  Scaffold showAppHomePage() {
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

  //ALTERNATE OF SWITH-CASE
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
    // if (selectedIndex == _flatListPageIndex) return FlatListPage();
    if (selectedIndex == _flatListPageIndex) {
      return HomeFlatsPage();
      // return context.watch<FlatListViweModel>().getWidget(context);
    }
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
