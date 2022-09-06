// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/home_provider.dart';

import '../../../../providers/newrenter_step_provider.dart';
import 'package:sweet_home/view/resources/app_icons.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faltProvider = context.watch<HomeProvider>();
    final provider = context.watch<NewRenterStepProvider>();

    int flatNo = provider.selectedFlatNo!;
    String assignedFlatNo = faltProvider.flats[flatNo].flatName;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, bottom: 50),
        child: Column(
          children: [
            Lottie.asset(
              AppIcons.doneLottie,
              height: 150,
              repeat: false,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              '$assignedFlatNo ফ্ল্যাটে গ্রাহক যুক্ত করা হয়েছে',
              style: Theme.of(context).textTheme.headline6,
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: Text(
                  'ফিরে যাই',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
