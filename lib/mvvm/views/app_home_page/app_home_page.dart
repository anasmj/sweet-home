import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/views/current_month/current_month.dart';
import 'package:sweet_home/mvvm/views/flats/all_flat.dart';
import '../../providers/current_home.dart';
import '../flats/home_flats.dart';
import '../pendings/all_pending_page.dart';

import 'components/drawer.dart';

enum SelectedPage { currentMonth, flats, pendings }

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePage();
}

class _AppHomePage extends State<AppHomePage> {
  int _defaultTabIndex = 1;
  SelectedPage selectedPage = SelectedPage.flats;

  final double _appBarHeight = 280;
  bool isInitialState = false;

  //! SETS THE FIRST HOME AS CURRENT HOME IF NO HOME IS SELECTED PREVIOUSLY
  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider providerRead = context.watch<CurrentHomeProvider>();

    return Scaffold(
      drawer: AppDrawer(),
      bottomNavigationBar: getBottomNavBar(),
      body: getUserSelectedPage(context),
    );
  }

  BottomNavigationBar getBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _defaultTabIndex,
      onTap: (newIndex) {
        setState(() {
          switch (newIndex) {
            case 0:
              selectedPage = SelectedPage.currentMonth;
              break;
            case 1:
              selectedPage = SelectedPage.flats;
              break;
            case 2:
              selectedPage = SelectedPage.pendings;
              break;
          }
        });
        _defaultTabIndex = newIndex;
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), label: 'চলতি মাস '),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ফ্ল্যাটগুলি'),
        BottomNavigationBarItem(icon: Icon(Icons.pending), label: 'বকেয়া সমূহ'),
      ],
    );
  }

  //ALTERNATE OF SWITH-CASE
  Widget getUserSelectedPage(BuildContext context) {
    if (selectedPage == SelectedPage.currentMonth) {
      return CurrentMonth(appBarHeight: _appBarHeight);
    }
    if (selectedPage == SelectedPage.flats) {
      return AllFlat();
      // return context.watch<FlatListViweModel>().getWidget(context);
    }
    if (selectedPage == SelectedPage.pendings) return AllPendingPage();
    return const SizedBox();
  }
}