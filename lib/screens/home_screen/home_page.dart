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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              children: [
                const Spacer(),
                Text(DateAndTime().currentDateAndMonth()),
              ],
            ),
            centerTitle: true,
            expandedHeight: 260,
            flexibleSpace: Column(
              children: <Widget>[
                const SizedBox(
                  // upper space
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 80, left: 40, right: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 10,
                        offset: const Offset(-2, 3),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: 160,
                  //width: 50,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        // upper space
                        height: 10,
                      ),
                      const Text(
                        'এক নজরে',
                        style: TextStyle(fontSize: 22),
                      ),
                      DataTable(
                        dividerThickness: 3,
                        dataTextStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        headingTextStyle: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w600),
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text('মোট পাবো'),
                          ),
                          DataColumn(
                            label: Text('বুঝে পেয়েছি'),
                          )
                        ],
                        rows: [
                          DataRow(cells: <DataCell>[
                            DataCell(
                              Row(
                                children: [
                                  getIcon(AppIcons().takaUrl),
                                  getAmountText(56000),
                                ],
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  getIcon(AppIcons().takaUrl),
                                  getAmountText(12000),
                                ],
                              ),
                            ),
                          ]),
                          // DataRow(
                          //   label: Text('বুঝে পেয়েছি'),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
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
