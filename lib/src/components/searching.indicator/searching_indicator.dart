import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sweet_home/src/constants/asset.path.dart';

class SearchingIndicator extends StatelessWidget {
  const SearchingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AssetPath.searching,
        ),
      ),
    );
  }
}
