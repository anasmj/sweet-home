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
        context.watch<FlatViewModel>().userFlat?.renter?.renterDue;

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

// ignore: must_be_immutable
class RecievedRow extends StatelessWidget {
  RecievedRow({super.key, required this.amount});
  double? amount;
  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.w500);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('পেয়েছি', style: style),
        Text(
          amount != null ? Formatter.toBn(value: amount) : '-',
          style: style.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MonthlyDueRow extends StatelessWidget {
  const MonthlyDueRow({super.key, required this.amount});
  final double amount;

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.w500);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('মাসিক বকেয়া', style: style),
        Text(
          Formatter.toBn(value: amount),
          style: style.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
          Formatter.toBn(value: context.watch<FlatViewModel>().total),
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
          Formatter.toBn(value: context.watch<FlatViewModel>().total),
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
