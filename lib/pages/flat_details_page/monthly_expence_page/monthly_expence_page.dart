import 'package:flutter/material.dart';
import '../../../models/renter.dart';
import 'components/monthly_expence_table.dart';

class MonthlyExpencePage extends StatelessWidget {
  MonthlyExpencePage({
    required this.renter,
    Key? key,
  }) : super(key: key);

  Renter renter;
  @override
  Widget build(BuildContext context) {
    TextStyle colTitleText = Theme.of(context).textTheme.headline6!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          //BUTTON
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Text('পূর্বের হিসাবসমূহ'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16)
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'বিবরণ',
                  style: colTitleText,
                ),
                Text(
                  'টাকার পরিমাণ',
                  style: colTitleText,
                ),
              ],
            ),
          ),

          //DATA TABLE

          MonthlyExpenceTable(renter: renter),
        ],
      ),
    );
  }
}
