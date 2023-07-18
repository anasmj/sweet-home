import 'package:flutter/material.dart';
import 'package:sweet_home/src/utils/form_validators.dart';

class PaymentTextField extends StatelessWidget {
  const PaymentTextField({
    super.key,
  });
  final double _width = 140;
  final double _fontSize = 24;
  final double _cursorHeight = 28;
  final double _fromLeft = 12.0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SizedBox(
        width: _width,
        child: TextFormField(
          //! this line keep showing error after clearing the  textifeld
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormValidators.checkNonZero,
          style: TextStyle(fontSize: _fontSize),
          cursorHeight: _cursorHeight,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 0.01),
            contentPadding: EdgeInsets.only(left: _fromLeft),
            prefixStyle: TextStyle(fontSize: _fontSize),
            prefixText: '৳ ',
          ),
        ),
      ),
    );
  }
}
