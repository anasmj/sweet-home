import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/extensions/extensions.dart';
import 'package:sweet_home/src/modules/new_home_stepper/view/new_home_stepper.dart';

class EmptyHomePage extends StatelessWidget {
  const EmptyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double arrowIconFromLeft = MediaQuery.of(context).size.width * 0.55;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Lottie.asset(
            AssetPath.homePopUp,
            height: 300,
            repeat: false,
          ),
          Text(
            'Add new home from here',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 100.0,
              left: arrowIconFromLeft,
            ),
            child: Lottie.asset(
              AssetPath.arrowDown,
              height: 150,
              repeat: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
          context.push(const AddHomeStepper());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
