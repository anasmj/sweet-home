import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/edit_textfield.dart';
import 'package:sweet_home/prev/utils/home_crud.dart';

import 'update_button.dart';

// ignore: must_be_immutable
class HomeInfoModalContent extends StatelessWidget {
  HomeInfoModalContent({
    super.key,
    required this.home,
    required this.title,
    this.isNumeric = true,
    this.isDouble = false,
    this.isInt = false,
    this.validationFunciton,
  });
  Home home;
  String title;
  String? Function(String?)? validationFunciton;
  bool isNumeric;
  bool isDouble, isInt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 30),
            child: modalSheetDivider(),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: context.read<CurrentHomeProvider>().editFormKey,
              child: EditTextField(
                label: title,
                validationFunciton: validationFunciton,
                isNumeric: isNumeric,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          UpdateButton(
            onUpdated: () {
              onUpdateField(
                context: context,
                home: home,
                title: title,
                //for typecasting purpose
                isDouble: isDouble,
                isInt: isInt,
              );
              context.read<CurrentHomeProvider>().displayTextController.clear();
            },
          ),
        ],
      ),
    );
  }

  RoundedRectangleBorder modalSheetStyle() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }

  Widget modalSheetDivider() {
    return Builder(builder: (context) {
      bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
      return Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: isDarkMode ? Colors.white60 : Colors.grey.shade700,
        ),
        height: 4,
        width: 20,
      );
    });
  }
}
