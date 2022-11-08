import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';

class TotaBilllRow extends StatelessWidget {
  const TotaBilllRow({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "মোট",
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          Formatter.toBn(value: context.watch<FlatViewModel>().total ?? 0.0),
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
