import 'package:flutter/material.dart';

//! do not change
// ignore: must_be_immutable
class UpdateButton extends StatelessWidget {
  UpdateButton({
    Key? key,
    required this.buttonTitle,
    this.onPressed,
  }) : super(key: key);
  VoidCallback? onPressed;
  final double buttonFontSize = 16;
  String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          'আপডেট করুন',
          style: TextStyle(fontSize: buttonFontSize),
        ),
      ),
    );
  }

  CircularProgressIndicator getWaitingWidget() {
    return const CircularProgressIndicator(
      strokeWidth: 3,
      color: Colors.white,
    );
  }
}
