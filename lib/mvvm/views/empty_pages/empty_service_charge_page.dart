import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/views/resources/image_url.dart';

class EmptyServiceChargePage extends StatelessWidget {
  const EmptyServiceChargePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageUrl.emptyBox,
            height: MediaQuery.of(context).size.height / 3,
          ),
          Text(
            'খরচ যুক্ত করুন',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      )),
    );
  }
}
