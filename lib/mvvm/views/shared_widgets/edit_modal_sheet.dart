import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/edit_textfield.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/update_button.dart';

// ignore: must_be_immutable
class EditModalSheet extends StatelessWidget {
  EditModalSheet({
    super.key,
    required this.sheetTitle,
    this.isNumeric = true,
    this.isDouble = false,
    this.isInt = false,
    this.validationFunciton,
    this.textFieldLabel,
    required this.onUpdated,
    this.formKey,
    this.controller,
  });

  String sheetTitle;
  String? textFieldLabel;
  String? Function(String?)? validationFunciton;
  bool isNumeric;
  bool isDouble, isInt;
  VoidCallback onUpdated;
  Key? formKey;
  TextEditingController? controller;

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
            sheetTitle,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: formKey,
              child: EditTextField(
                label: textFieldLabel ?? '',
                validationFunciton: validationFunciton,
                isNumeric: isNumeric,
                editingController: controller,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          UpdateButton(
            buttonTitle: 'আপডেট',
            onPressed: onUpdated,
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
