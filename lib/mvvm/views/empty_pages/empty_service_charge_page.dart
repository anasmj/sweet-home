import 'package:flutter/material.dart';
import '../resources/image_urls.dart';

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
            'কোনও খরচ যুক্ত নেই',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      )),
    );
  }
}
