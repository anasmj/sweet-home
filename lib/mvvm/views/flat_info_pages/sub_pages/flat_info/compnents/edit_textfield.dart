import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/current_home.dart';

// ignore: must_be_immutable
class EditTextField extends StatelessWidget {
  EditTextField({
    this.label = '',
    this.isNumeric = false,
    this.validationFunciton,
    this.isDisabled = true,
    super.key,
  });

  String? Function(String?)? validationFunciton;

  String label;
  bool isNumeric;
  bool isDisabled;

  final double _cursorHeight = 22;

  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider provider = context.read<CurrentHomeProvider>();
    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: isDisabled,
      controller: provider.displayTextController,
      validator: validationFunciton,
      cursorHeight: _cursorHeight,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.name,
      decoration: InputDecoration(
        label: Text(
          label,
          style: formTextStyle,
        ),
        suffixIcon: const Icon(Icons.edit),
      ),
    );
  }
}
