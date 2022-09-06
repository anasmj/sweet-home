import 'package:flutter/material.dart';
import '../../../resources/app_icons.dart';

//*complete
class MonthlySummaryCard extends StatelessWidget {
  const MonthlySummaryCard({super.key});
  final double _appIconHeight = 22;
  final double _appIconWidth = 22;
  final double _containerHeight = 150;
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
        // color:
        // currentTheme.isDarkMode ? Colors.grey.shade600 : Colors.blue[200],
        color: Theme.of(context).secondaryHeaderColor,
      ),
      height: _containerHeight,
      //width: 50,
      child: Column(
        children: <Widget>[
          const SizedBox(
            // upper space
            height: 10,
          ),
          const Text(
            'এক নজরে',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          DataTable(
            dividerThickness: 3,
            dataTextStyle: const TextStyle(fontSize: 18, color: Colors.black),
            headingTextStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.w600),
            columns: <DataColumn>[
              DataColumn(
                label: Text(
                  'মোট পাবো',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              DataColumn(
                label: Text(
                  'বুঝে পেয়েছি',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )
            ],
            rows: [
              DataRow(cells: <DataCell>[
                DataCell(
                  Row(
                    children: [
                      getIcon(AppIcons.takaUrl),
                      getAmountText(context, 56000),
                    ],
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      getIcon(AppIcons.takaUrl),
                      getAmountText(context, 12000),
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
          color: Colors.red[900],
          image: AssetImage(AppIcons.takaUrl),
        ),
      );

  //TODO: make it fancy by puttin comma between digits
  Widget getAmountText(context, int amount) => Text(
        ' ${amount.toString()}', style: Theme.of(context).textTheme.headline6,
        // style: TextStyle(
        //   fontWeight: FontWeight.bold,
        //   color: Colors.grey.shade900,
        //   fontSize: 22,
        // ),
      );
}
