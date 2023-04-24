import 'package:flutter/material.dart';

import 'monthly_summary_card.dart';
import 'summary_container.dart';

class CustomSliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  CustomSliverAppbarDelegate({
    required this.expandedHeight,
  });

  final double _summaryCardHeight = 150;
  final double _fromTop = 90;

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
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SummaryContainer(
                txt: 'সম্পূর্ণ ', summaryColor: Colors.green.shade300, num: 4),
            SummaryContainer(
              txt: 'আংশিক',
              summaryColor: Colors.yellow.shade300,
              num: 1,
            ),
            SummaryContainer(
              txt: 'বাকি',
              summaryColor: Colors.red.shade400,
              num: 2,
            ),
          ],
        ),
      );
    });
  }
}
