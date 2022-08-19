import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StepperTextField extends StatelessWidget {
  StepperTextField(
      {this.label = '',
      this.isAstrics = false,
      this.isPhoneNumber = false,
      super.key});

  String label;
  bool isAstrics, isPhoneNumber;
  final double _cursorHeight = 22;
  final double _textFieldHeight = 50;
  @override
  Widget build(BuildContext context) {
    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    return SizedBox(
      height: _textFieldHeight,
      child: isAstrics
          ? TextFormField(
              cursorHeight: _cursorHeight,
              keyboardType:
                  isPhoneNumber ? TextInputType.number : TextInputType.name,
              decoration: InputDecoration(
                label: getLabelWithAstrics(
                  label: label,
                  textStyle: formTextStyle,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          : TextFormField(
              cursorHeight: _cursorHeight,
              decoration: InputDecoration(
                label: Text(
                  label,
                  style: formTextStyle,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
