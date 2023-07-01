import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/utils/formatter.dart';

import 'monthly_data_table.dart';

// Ongoing month summary
// ignore: must_be_immutable
class CurrentMonthContent extends StatelessWidget {
  CurrentMonthContent({super.key});

  bool isInitialState = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: isInitialState
          ? Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.3),
              child: SvgPicture.asset(
                AssetPath.noDataUrl,
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
                      date: Formatter().currentMonthYearBn(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: MonthlyDataTable(
                      title: "আগের মাসের হিসাব",
                      date: Formatter().previousMonthYearBn(),
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
