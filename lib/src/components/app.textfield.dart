import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  AppTextField({
    this.textEditingController,
    this.label,
    this.validator,
    this.inputType,
    this.onChanged,
    super.key,
  });

  String? label;
  String? Function(String?)? validator;
  final double _cursorHeight = 22;
  TextInputType? inputType;
  TextEditingController? textEditingController;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    TextStyle formTextStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.black.withOpacity(0.8),
        );
    return TextFormField(
      
      controller: textEditingController,
      validator: validator,
      cursorHeight: _cursorHeight,
      keyboardType: inputType,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        label: Text(
          label ?? '',
          style: formTextStyle,
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
      ),
    );
  }
}
