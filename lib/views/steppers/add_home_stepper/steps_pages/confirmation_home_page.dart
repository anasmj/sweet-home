// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sweet_home/views/styling/app_icons.dart';

class ConfirmHomePage extends StatelessWidget {
  const ConfirmHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final faltProvider = context.watch<HomeProvider>();
    // final provider = context.watch<NewRenterStepProvider>();

    // int flatNo = provider.selectedFlatNo!;
    // String assignedFlatNo = faltProvider.flats[flatNo].flatName;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, bottom: 50),
        child: Column(
          children: [
            Lottie.asset(
              AppIcons.createHome,
              height: 350,
              repeat: true,
            ),
            Text(
              'বাড়ীটি যুক্ত করা হয়েছে',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 60,
            ),
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