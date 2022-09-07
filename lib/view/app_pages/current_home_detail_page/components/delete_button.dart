import 'package:flutter/material.dart';

import '../../../resources/app_icons.dart';

class DeleteButton extends StatelessWidget {
  DeleteButton({
    Key? key,
  }) : super(key: key);

  final String _buttonText = 'ডিলিট';
  final double _iconWidthAndHeight = 16;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          side: const BorderSide(
        width: 1,
        color: Colors.red,
        style: BorderStyle.solid,
      )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: Image.asset(
                  AppIcons.binUrl,
                  height: _iconWidthAndHeight,
                  width: _iconWidthAndHeight,
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: ' $_buttonText',
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
