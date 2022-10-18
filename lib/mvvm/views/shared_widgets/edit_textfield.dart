import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditTextField extends StatelessWidget {
  EditTextField({
    this.label = '',
    this.isNumeric = false,
    this.validationFunciton,
    this.isEnabled = true,
    super.key,
    this.editingController,
    this.textFieldContent,
  });

  String? Function(String?)? validationFunciton;

  String label;
  bool isNumeric;
  bool isEnabled;
  TextEditingController? editingController;
  dynamic textFieldContent;

  final double _cursorHeight = 22;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: isEnabled,
      controller: editingController,
      validator: validationFunciton,
      cursorHeight: _cursorHeight,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.name,
      decoration: InputDecoration(
        prefixText: isNumeric ? '৳' : '',
        suffixIcon: const Icon(Icons.edit),
      ),
    );
  }
}
