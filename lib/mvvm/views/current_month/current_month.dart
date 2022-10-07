import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/views/current_month/components/current_month_content.dart';

import 'components/custom_appbar.dart';

class CurrentMonth extends StatelessWidget {
  const CurrentMonth({
    Key? key,
    required double appBarHeight,
  })  : _appBarHeight = appBarHeight,
        super(key: key);

  final double _appBarHeight;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: ScrollController(),
      slivers: [
        SliverPersistentHeader(
          //APP BAR
          delegate: CustomSliverAppbarDelegate(expandedHeight: _appBarHeight),
          pinned: false,
        ),
        SliverToBoxAdapter(
          child: CurrentMonthContent(),
        ),
      ],
    );
  }
}
