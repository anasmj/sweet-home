import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StepperTextField extends StatelessWidget {
  StepperTextField(
      {this.label = '',
      this.isAstrics = false,
      this.isNumeric = false,
      this.validationFunciton,
      this.isDisabled = true,
      required this.textEditingController,
      super.key});

  String? Function(String?)? validationFunciton;

  String label;
  bool isAstrics, isNumeric;
  final double _fontSize = 14;
  final double _cursorHeight = 22;
  TextEditingController textEditingController;
  bool isDisabled;
  @override
  Widget build(BuildContext context) {
    return isAstrics
        ? TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: isDisabled,
            controller: textEditingController,
            validator: validationFunciton,
            cursorHeight: _cursorHeight,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.name,
            decoration: InputDecoration(
              label: getLabelWithAstrics(
                context: context,
                label: label,
              ),
            ),
          )
        : TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: isDisabled,
            controller: textEditingController,
            validator: validationFunciton,
            cursorHeight: _cursorHeight,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.name,
            decoration: InputDecoration(
              label: Text(
                label,
                style: Theme.of(context)
                    .inputDecorationTheme
                    .labelStyle!
                    .copyWith(fontSize: _fontSize),
              ),
            ),
          );
  }

  RichText getLabelWithAstrics({context, required String label}) {
    return RichText(
      text: TextSpan(
        // style: textStyle,
        children: [
          TextSpan(
            text: label,
            style: Theme.of(context)
                .inputDecorationTheme
                .labelStyle!
                .copyWith(fontSize: _fontSize),
          ),
          TextSpan(
            text: ' *',
            style: TextStyle(
              color: Colors.red[900],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
