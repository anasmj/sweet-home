import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../resources/app_icons.dart';

class SearchingIndicator extends StatelessWidget {
  const SearchingIndicator({
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
