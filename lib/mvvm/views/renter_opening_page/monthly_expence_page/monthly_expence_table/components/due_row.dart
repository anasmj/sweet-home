import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';

class DueRow extends StatelessWidget {
  DueRow({super.key, required this.textTheme, required this.account});

  final TextTheme textTheme;
  double account;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "আগের বকেয়া",
          style: textTheme.titleMedium,
        ),
        Text(
          Formatter.toBn(value: account.abs()),
          style: textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.red[900]),
        ),
      ],
    );
  }
}
