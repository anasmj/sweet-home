import 'package:flutter/material.dart';

class AdvancePaymentCheckbox extends StatefulWidget {
  const AdvancePaymentCheckbox({super.key});

  @override
  State<AdvancePaymentCheckbox> createState() => _AdvanceCheckboxState();
}

class _AdvanceCheckboxState extends State<AdvancePaymentCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (value) => setState(
        () {
          isChecked = !isChecked;
        },
      ),
    );
  }
}
