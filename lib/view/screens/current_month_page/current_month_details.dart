import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/utils/custom_date_time_formatter.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/view/resources/app_icons.dart';
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
                  const SizedBox(height: 40),

                  const SizedBox(height: 60),
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
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
    );
  }
}
