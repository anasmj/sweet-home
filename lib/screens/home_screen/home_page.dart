//* THIS IS FOLLOWED BY DESIGNE

import 'package:flutter/material.dart';
import 'package:rent_home/controller/date_and_time.dart';

import '../../app_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final double _appIconHeight = 20;
  final double _appIconWidth = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                //pinned: true,
                title: Row(
                  children: [
                    const SizedBox(
                      width: 250,
                      child: Text(
                        '232 West Nakhalpara',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                    Text(DateAndTime().currentDateAndMonth()),
                  ],
                ),
                bottom: const TabBar(
                  tabs: [
                    Text('মাসিক হিসাব'),
                    Text('বকেয়াসমূহ'),
                    Text('সকল গ্রাহক'),
                    Text('আমার খরচ'),
                  ],
                ),
              ),
            ];
          },
          body: Container(),
        ),
      ),
    );

    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     drawer: const Drawer(),
    //     body: DefaultTabController(
    //       length: 4,
    //       child: NestedScrollView(
    //         headerSliverBuilder: (context, value) {
    //           return [
    //             SliverAppBar(
    //               bottom: const TabBar(
    //                 tabs: [
    //                   Text('মাসিক হিসাব'),
    //                   Text('বকেয়াসমূহ'),
    //                   Text('সকল গ্রাহক'),
    //                   Text('আমার খরচ'),
    //                 ],
    //               ),
    //               title: Row(
    //                 children: [
    //                   const Spacer(),
    //                   Text(DateAndTime().currentDateAndMonth()),
    //                 ],
    //               ),
    //               centerTitle: true,
    //               expandedHeight: 280,
    //               flexibleSpace: Column(
    //                 children: <Widget>[
    //                   const SizedBox(
    //                     // upper space
    //                     height: 10,
    //                   ),
    //                   Container(
    //                     margin:
    //                         const EdgeInsets.only(top: 80, left: 40, right: 40),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(10),
    //                       boxShadow: [
    //                         BoxShadow(
    //                           color: Colors.black.withOpacity(0.6),
    //                           blurRadius: 10,
    //                           offset: const Offset(-2, 3),
    //                         ),
    //                       ],
    //                       color: Colors.white,
    //                     ),
    //                     height: 160,
    //                     //width: 50,
    //                     child: Column(
    //                       children: <Widget>[
    //                         const SizedBox(
    //                           // upper space
    //                           height: 10,
    //                         ),
    //                         const Text(
    //                           'এক নজরে',
    //                           style: TextStyle(fontSize: 22),
    //                         ),
    //                         DataTable(
    //                           dividerThickness: 3,
    //                           dataTextStyle: const TextStyle(
    //                               fontSize: 18, color: Colors.black),
    //                           headingTextStyle: Theme.of(context)
    //                               .textTheme
    //                               .subtitle1!
    //                               .copyWith(fontWeight: FontWeight.w600),
    //                           columns: const <DataColumn>[
    //                             DataColumn(
    //                               label: Text('মোট পাবো'),
    //                             ),
    //                             DataColumn(
    //                               label: Text('বুঝে পেয়েছি'),
    //                             )
    //                           ],
    //                           rows: [
    //                             DataRow(cells: <DataCell>[
    //                               DataCell(
    //                                 Row(
    //                                   children: [
    //                                     getIcon(AppIcons().takaUrl),
    //                                     getAmountText(56000),
    //                                   ],
    //                                 ),
    //                               ),
    //                               DataCell(
    //                                 Row(
    //                                   children: [
    //                                     getIcon(AppIcons().takaUrl),
    //                                     getAmountText(12000),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ]),
    //                             // DataRow(
    //                             //   label: Text('বুঝে পেয়েছি'),
    //                             // )
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ];
    //         },
    //         body: const TabBarView(
    //           children: [
    //             Center(
    //               child: Text('tab 1'),
    //             ),
    //             Center(
    //               child: Text('tab 2'),
    //             ),
    //             Center(
    //               child: Text('tab 3'),
    //             ),
    //             Center(
    //               child: Text('tab 4'),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),

    //   );
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

class NormalAppBar extends StatelessWidget {
  const NormalAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Row(
            children: [
              const SizedBox(
                width: 250,
                child: Text(
                  '232 West Nakhalpara',
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
              Text(DateAndTime().currentDateAndMonth()),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Text('মাসিক হিসাব'),
              Text('বকেয়াসমূহ'),
              Text('সকল গ্রাহক'),
              Text('আমার খরচ'),
            ],
          ),
        ),
      ),
    );
  }
}
