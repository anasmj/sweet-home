import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StepperTextField extends StatelessWidget {
  StepperTextField({
    this.label = '',
    this.isAstrics = false,
    this.isNumeric = false,
    this.validation,
    this.isDisabled = true,
    this.textEditingController,
    this.onChanged,
    this.hint,
    this.initialValue,
    super.key,
  });

  String? Function(String?)? validation;
  String? Function(String?)? onChanged;

  String label;
  String? hint;
  String? initialValue;
  bool isAstrics, isNumeric;
  final double _cursorHeight = 22;
  TextEditingController? textEditingController;
  bool isDisabled;
  @override
  Widget build(BuildContext context) {
    return isAstrics
        ? TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: isDisabled,
            initialValue: initialValue,
            controller: textEditingController,
            validator: validation,
            cursorHeight: _cursorHeight,
            onChanged: onChanged,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.name,
            decoration: InputDecoration(
              label: LableWithAstrics(label: label),
              hintText: hint,
            ),
          )
        : TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: isDisabled,
            initialValue: initialValue,
            controller: textEditingController,
            validator: validation,
            onChanged: onChanged,
            cursorHeight: _cursorHeight,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.name,
            decoration: InputDecoration(
              label: Text(
                label,
              ),
              hintText: hint,
            ),
          );
  }
}

class LableWithAstrics extends StatelessWidget {
  const LableWithAstrics({super.key, this.label});
  final String? label;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(color: Colors.black),
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
