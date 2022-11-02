import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/renter_view_model.dart';

class GrandTotalRow extends StatelessWidget {
  const GrandTotalRow({
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
          "সর্বমোট",
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          Formatter.toBn(
              value: context.watch<RenterViewModel>().totalBill ?? 0),
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
