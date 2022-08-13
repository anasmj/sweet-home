import 'package:flutter/material.dart';
import 'package:rent_home/utils/custom_date_time_formatter.dart';
import 'components/monthly_data_table.dart';
import 'components/monthly_summary_card.dart';
import 'components/summary_container.dart';

// Ongoing month summary
class CurrentMonthPage extends StatelessWidget {
  const CurrentMonthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(),
          const MonthlySummaryCard(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Material(
                  elevation: 10.0,
                  child: SummaryContainer(
                      txt: 'সম্পূর্ণ দিয়েছেন',
                      summaryColor: Colors.green.withOpacity(0.8),
                      num: 5),
                ),
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

          //monthly details tables
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: MonthlyDataTable(
              title: 'চলতি মাসের হিসাব',
              date: CustomFormatter().monthAndYear(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: MonthlyDataTable(
              title: "আগের মাসের হিসাব",
              date: CustomFormatter().previousMonthAndYear(),
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
