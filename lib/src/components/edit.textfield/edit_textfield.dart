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
    this.withEditIcon = true,
  });

  String? Function(String?)? validationFunciton;

  String label;
  bool isNumeric;
  bool isEnabled;
  TextEditingController? editingController;
  dynamic textFieldContent;
  bool withEditIcon;

  final double _cursorHeight = 22;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: isEnabled,
      controller: editingController,
      validator: validationFunciton,
      cursorHeight: _cursorHeight,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.name,
      decoration: InputDecoration(
        prefixText: isNumeric ? '৳' : '',
        suffixIcon:
            withEditIcon ? const Icon(Icons.edit) : const SizedBox.shrink(),
      ),
    );
  }
}
