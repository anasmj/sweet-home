import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/views/app_home_page/sub_pages/current_month_page/components/current_month_content.dart';

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
