import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../prev/view/resources/app_icons.dart';

class SearchingForHome extends StatelessWidget {
  const SearchingForHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AppIcons.searching,
        ),
      ),
    );
  }
}
