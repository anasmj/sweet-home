import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/profile.dart';
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
  final double _fromTop = 90;

  appear(double shrinkOffset) => shrinkOffset / expandedHeight;
  dissapear(double shrinkOffset) => (1 - (shrinkOffset / expandedHeight));
  bool showWithData = Profile.userName == 'Tanzid';
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
          Positioned(
            top: 1 - shrinkOffset + _fromTop,
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
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SummaryContainer(
              txt: 'সম্পূর্ণ ',
              summaryColor: mode.isDarkMode
                  ? Colors.green.shade300
                  : Colors.green.shade400,
              num: showWithData ? 5 : 0,
            ),
            SummaryContainer(
                txt: 'আংশিক',
                summaryColor: mode.isDarkMode
                    ? Colors.yellow.shade300
                    : Colors.yellow.shade400,
                num: showWithData ? 5 : 0),
            SummaryContainer(
              txt: 'বাকি',
              summaryColor:
                  mode.isDarkMode ? Colors.red.shade300 : Colors.red.shade400,
              num: showWithData ? 5 : 0,
            ),
          ],
        ),
      );
    });
  }
}
