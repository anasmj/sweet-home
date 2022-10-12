import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.troubleUrl,
            width: 250,
          ),
          Text(
            'কোনও একটি সমস্যা হয়েছে',
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    ));
  }
}
