import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

class EmptyTransaction extends StatelessWidget {
  const EmptyTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppIcons.noListUrl,
            height: 180,
          ),
          const Text(
            'গ্রাহকের সাথে আপনার লেনদেনসমূহ \nএখানে দেখতে পাবেন',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
