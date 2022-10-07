import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          'সেভ',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
