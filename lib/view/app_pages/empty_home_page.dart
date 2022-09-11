import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/routes.dart';
import '../resources/app_icons.dart';

class EmptyHomePage extends StatelessWidget {
  const EmptyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double arrowIconFromLeft = MediaQuery.of(context).size.width * 0.55;
    return Scaffold(
      appBar: AppBar(
        title: const Text('বাড়ী যুক্ত করুন'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Lottie.asset(
            AppIcons.homePopUp,
            height: 350,
            repeat: false,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 100.0, left: arrowIconFromLeft),
            child: Lottie.asset(
              AppIcons.arrowDown,
              height: 200,
              repeat: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
          AppRoute.newHomeStepper(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
