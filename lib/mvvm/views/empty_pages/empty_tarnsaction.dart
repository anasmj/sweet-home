import 'package:flutter/material.dart';

class EmptyTransaction extends StatelessWidget {
  const EmptyTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'গ্রাহকের সাথে আপনার লেনদেনসমূহ ',
        style: TextStyle(fontSize: 18),
      ),
      // child: MonthlyExpencePage(renter: renter),
    );
  }
}
