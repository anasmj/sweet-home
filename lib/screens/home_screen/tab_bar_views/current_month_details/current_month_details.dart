import 'package:flutter/material.dart';
import 'package:rent_home/screens/home_screen/components/monthly_summary_card.dart';
import 'package:rent_home/utils/date_and_time.dart';

import 'components/monthly_data_table.dart';
import 'components/summary_container.dart';

class CurrentMonthDetails extends StatelessWidget {
  const CurrentMonthDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MonthlySummaryCard(), //TODO: reduce shadow, elevatio 1 might be enouh
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SummaryContainer(
                    txt: 'সম্পূর্ণ দিয়েছেন',
                    summaryColor: Colors.green,
                    num: 5),
                SummaryContainer(
                    txt: 'আংশিক দিয়েছেন', summaryColor: Colors.yellow, num: 1),
                SummaryContainer(
                    txt: 'বাকি আছেন', summaryColor: Colors.orange, num: 1),
              ]
                  .map((e) => Padding(
                        //horizontal space
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: e,
                      ))
                  .toList(),
            ),
          ),

          MonthlyDataTable(
            title: 'চলতি মাসের হিসাব',
            date: DateAndTime().monthAndYear(),
          ),
          MonthlyDataTable(
            title: "আগের মাসের হিসাব",
            date: DateAndTime().previousMonthAndYear(),
          ),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
