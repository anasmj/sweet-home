import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../current_month_page/components/monthly_summary_card.dart';
import '../../current_month_page/components/summary_container.dart';

class CustomSliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  CustomSliverAppbarDelegate({
    required this.expandedHeight,
  });

  final double _summaryCardsRowHeight = 90;
  final double _summaryCardHeight = 150;

  appear(double shrinkOffset) => shrinkOffset / expandedHeight;
  dissapear(double shrinkOffset) => (1 - (shrinkOffset / expandedHeight));

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AppBar(
      elevation: 0.0,
      flexibleSpace: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: expandedHeight,
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Opacity(
              opacity: dissapear(shrinkOffset),
              child: getSummaries(),
            ),
          ),
          Positioned(
            top: expandedHeight - shrinkOffset - _summaryCardHeight / 2,
            left: 50,
            right: 50,
            child: const MonthlySummaryCard(),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;
  @override
  double get minExtent => kToolbarHeight + 30;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget getSummaries() {
    return Builder(builder: (context) {
      final mode = context.watch<ThemeProvider>();

      return SizedBox(
        height: _summaryCardsRowHeight,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              child: SummaryContainer(
                txt: 'সম্পূর্ণ দিয়েছেন',
                summaryColor: mode.isDarkMode
                    ? Colors.green.shade300
                    : Colors.green.shade400,
                num: 5,
              ),
            ),
            SummaryContainer(
                txt: 'আংশিক দিয়েছেন',
                summaryColor: mode.isDarkMode
                    ? Colors.yellow.shade300
                    : Colors.yellow.shade400,
                num: 1),
            SummaryContainer(
                txt: 'বাকি আছেন',
                summaryColor:
                    mode.isDarkMode ? Colors.red.shade300 : Colors.red.shade400,
                num: 1),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: e,
                  ))
              .toList(),
        ),
      );
    });
  }
}
