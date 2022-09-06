import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditTextField extends StatelessWidget {
  EditTextField({
    this.label = '',
    this.isNumeric = false,
    this.validationFunciton,
    this.isDisabled = true,
    this.textEditingController,
    super.key,
  });

  String? Function(String?)? validationFunciton;

  String label;
  bool isNumeric;
  final double _cursorHeight = 22;
  TextEditingController? textEditingController;
  bool isDisabled;
  @override
  Widget build(BuildContext context) {
    TextStyle formTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: isDisabled,
      controller: textEditingController,
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
