import 'package:flutter/material.dart';

class NumberOfFlat extends StatelessWidget {
  const NumberOfFlat({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'ফ্ল্যাট সংখ্যাঃ ',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          TextSpan(
            text: '5 ',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
