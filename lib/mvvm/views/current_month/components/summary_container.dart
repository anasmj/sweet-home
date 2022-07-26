import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';

//returns summaray in the box
// ignore: must_be_immutable
class SummaryContainer extends StatelessWidget {
  SummaryContainer(
      {super.key,
      required this.txt,
      required this.summaryColor,
      required this.num});
  String txt;
  Color summaryColor;
  int num;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      width: 120,
      decoration: BoxDecoration(
        color: summaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Builder(
          builder: (context) => Column(
            children: [
              Text(
                txt,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
              ),
              Text(
                Formatter.toBn(value: num, includeSymbol: false),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              Text(
                "জন",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
