import 'package:flutter/material.dart';
import 'package:sweet_home/utils/custom_date_time_formatter.dart';

import 'components/bottom_banner.dart';
import 'components/monthly_expence_table.dart';

// ignore: must_be_immutable
class MonthlyExpencePage extends StatelessWidget {
  const MonthlyExpencePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle colTitleText = Theme.of(context).textTheme.headline6!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          //BUTTON
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  CustomFormatter().currentMonthYear(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Text('পূর্বের হিসাবসমূহ'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16)
                  ],
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'বিবরণ',
                  style: colTitleText,
                ),
                Text(
                  'টাকার পরিমাণ',
                  style: colTitleText,
                ),
              ],
            ),
          ),

          //DATA TABLE
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: MonthlyExpenceTable(),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: BottomBanner(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
