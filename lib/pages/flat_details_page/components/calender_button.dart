import 'package:flutter/material.dart';

class CalenderButton extends StatelessWidget {
  const CalenderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.calendar_month_rounded),
          Text(' 22 Jan \'22')
        ],
      ),
    );
  }
}
