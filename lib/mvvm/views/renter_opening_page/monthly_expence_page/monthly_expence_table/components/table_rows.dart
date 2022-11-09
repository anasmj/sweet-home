import 'package:flutter/material.dart';
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

class RecievedRow extends StatelessWidget {
  const RecievedRow({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.w500);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('বুঝে পেলাম', style: style),
        Text(
          '23421',
          style: style,
        ),
      ],
    );
  }
}

class MonthlyDueRow extends StatelessWidget {
  const MonthlyDueRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.w500);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('বাকি', style: style),
        Text(
          '23421',
          style: style,
        ),
      ],
    );
  }
}

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
          Formatter.toBn(value: context.watch<FlatViewModel>().total ?? 0),
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

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
