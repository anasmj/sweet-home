import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/controllers/custom_date_time_formatter.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/views/styling/app_icons.dart';
import 'components/monthly_data_table.dart';
import 'components/monthly_summary_card.dart';
import 'components/summary_container.dart';

// Ongoing month summary
// ignore: must_be_immutable
class CurrentMonthPage extends StatelessWidget {
  CurrentMonthPage({super.key});

  bool isInitialState = false;

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeProvider>();
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: isInitialState
          ? Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.3),
              child: SvgPicture.asset(
                AppIcons.noDataUrl,
                height: 140,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  const MonthlySummaryCard(),
                  const SizedBox(height: 40),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SummaryContainer(
                          txt: 'সম্পূর্ণ দিয়েছেন',
                          summaryColor: mode.isDarkMode
                              ? Colors.green.shade300
                              : Colors.green.shade400,
                          num: 5,
                        ),
                        SummaryContainer(
                            txt: 'আংশিক দিয়েছেন',
                            summaryColor: mode.isDarkMode
                                ? Colors.yellow.shade300
                                : Colors.yellow.shade400,
                            num: 1),
                        SummaryContainer(
                            txt: 'বাকি আছেন',
                            summaryColor: mode.isDarkMode
                                ? Colors.red.shade300
                                : Colors.red.shade400,
                            num: 1),
                      ]
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: e,
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  //monthly details tables
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: MonthlyDataTable(
                      title: 'চলতি মাসের হিসাব',
                      date: CustomFormatter().currentMonthYear(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: MonthlyDataTable(
                      title: "আগের মাসের হিসাব",
                      date: CustomFormatter().previousMonthYear(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
