import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';

// ignore: must_be_immutable
class DueRow extends StatelessWidget {
  const DueRow({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    double? dueAmount =
        context.watch<FlatViewModel>().userFlat?.renter?.dueAmount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "আগের বকেয়া",
          style: textTheme.titleMedium,
        ),
        Text(
          Formatter.toBn(value: dueAmount),
          style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: dueAmount! <= 0 ? Colors.green[900] : Colors.red[900]),
        ),
      ],
    );
  }
}
