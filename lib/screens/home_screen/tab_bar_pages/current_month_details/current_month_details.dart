import 'package:flutter/material.dart';
import 'package:rent_home/screens/home_screen/tab_bar_pages/current_month_details/components/monthly_summary_card.dart';
import 'package:rent_home/utils/date_and_time.dart';

import 'components/monthly_data_table.dart';
import 'components/summary_container.dart';

//  current month page
class CurrentMonthDetails extends StatelessWidget {
  const CurrentMonthDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(),
          const MonthlySummaryCard(), //TODO: reduce shadow, elevatio 1 might be enouh
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SummaryContainer(
                    txt: 'সম্পূর্ণ দিয়েছেন',
                    summaryColor: Colors.green.withOpacity(0.8),
                    num: 5),
                SummaryContainer(
                    txt: 'আংশিক দিয়েছেন',
                    summaryColor: Colors.yellowAccent.withOpacity(0.6),
                    num: 1),
                SummaryContainer(
                    txt: 'বাকি আছেন',
                    summaryColor: Colors.redAccent.withOpacity(0.8),
                    num: 1),
              ]
                  .map((e) => Padding(
                        //horizontal space
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: e,
                      ))
                  .toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: MonthlyDataTable(
              title: 'চলতি মাসের হিসাব',
              date: DateAndTime().monthAndYear(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: MonthlyDataTable(
              title: "আগের মাসের হিসাব",
              date: DateAndTime().previousMonthAndYear(),
            ),
          ),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
