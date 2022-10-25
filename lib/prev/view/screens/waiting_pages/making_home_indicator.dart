import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../mvvm/views/resources/app_icons.dart';

class MakingHomeIndicator extends StatelessWidget {
  const MakingHomeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              AppIcons.buildingHomeRed,
              // AppIcons.blueCircleIndicator,
              height: 150,
              repeat: true,
            ),
          ),
          Text(
            'আপনার বাড়ীটি তৈরি করা হচ্ছে . . ',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
