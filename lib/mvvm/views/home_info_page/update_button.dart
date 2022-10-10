import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/current_home.dart';

//! do not change
// ignore: must_be_immutable
class UpdateButton extends StatelessWidget {
  UpdateButton({
    Key? key,
    required this.onUpdated,
  }) : super(key: key);
  VoidCallback onUpdated;

  String buttonText = 'সেভ';

  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
      ),
      onPressed: onUpdated,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(buttonText,
            style: const TextStyle(
              fontSize: 18,
            )),
      ),
    );
  }
}
