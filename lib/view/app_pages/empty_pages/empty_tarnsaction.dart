import 'package:flutter/material.dart';

class EmptyContent {
  static Widget getEmptyTransactionPage() => const Center(
        child: Text(
          'গ্রাহকের সাথে আপনার লেনদেনসমূহ ',
          style: TextStyle(fontSize: 18),
        ),
        // child: MonthlyExpencePage(renter: renter),
      );
}
