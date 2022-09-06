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
  final double _cursorHeight = 22;
  TextEditingController textEditingController;
  bool isDisabled;
  @override
  Widget build(BuildContext context) {
    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
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
                label: label,
                textStyle: formTextStyle,
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
                // style: formTextStyle,
              ),
            ),
          );
  }

  RichText getLabelWithAstrics(
      {required String label, required TextStyle textStyle}) {
    return RichText(
      text: TextSpan(
        style: textStyle,
        children: [
          TextSpan(text: label),
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
