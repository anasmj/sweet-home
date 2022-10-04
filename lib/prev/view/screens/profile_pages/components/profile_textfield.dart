import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MakeProfileTextField extends StatelessWidget {
  MakeProfileTextField({
    required this.title,
    required this.controller,
    this.inputType = TextInputType.name,
    this.isPassword = false,
    Key? key,
  }) : super(key: key);
  String title;
  TextEditingController controller;
  TextInputType inputType;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      subtitle: TextField(
        obscureText: isPassword ? true : false,
        enableSuggestions: isPassword ? false : true,
        autocorrect: isPassword ? false : true,

        controller: controller,
        keyboardType: inputType,
        // keyboardType: isNumeric ? TextInputType.number : TextInputType.name,
        style: const TextStyle(fontSize: 16),
        cursorHeight: 24,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? passwordIcon()
              : controller.text.isEmpty
                  ? const Icon(Icons.add)
                  : const Icon(Icons.edit),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Icon passwordIcon() {
    return const Icon(
      Icons.arrow_forward_ios_outlined,
      size: 18,
    );
  }
}

class Section extends StatelessWidget {
  const Section({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.grey),
        ),
      ),
    );
  }
}
