import 'package:flutter/material.dart';

//returns summaray in the box
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: summaryColor, borderRadius: BorderRadius.circular(15)),
      //height: 100,
      child: Center(
        child: Builder(
            builder: (context) => Column(
                  children: [
                    Text(txt, style: Theme.of(context).textTheme.subtitle1),
                    Text(
                      num.toString(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "জন",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                )),
      ),
    );
  }
}
