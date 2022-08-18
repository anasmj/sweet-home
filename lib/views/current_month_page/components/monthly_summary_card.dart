import 'package:flutter/material.dart';

import '../../app_icons.dart';

//*complete
class MonthlySummaryCard extends StatelessWidget {
  const MonthlySummaryCard({super.key});
  final double _appIconHeight = 20;
  final double _appIconWidth = 20;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
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
            dataTextStyle: const TextStyle(fontSize: 18, color: Colors.black),
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
            ],
          ),
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
