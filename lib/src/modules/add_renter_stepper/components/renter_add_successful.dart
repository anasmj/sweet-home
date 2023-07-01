// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sweet_home/src/constants/constants.dart';

class AddRenterSuccessfulPage extends StatelessWidget {
  const AddRenterSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Lottie.asset(
              AssetPath.doneLottie,
              height: 120,
              repeat: false,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'ফ্ল্যাটটিতে গ্রাহক যুক্ত করা হয়েছে',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 150,
            ),
            goBackButton(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton goBackButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      )),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
        child: Text(
          'ফিরে যাই',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
