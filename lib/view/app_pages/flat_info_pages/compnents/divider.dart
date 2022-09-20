import 'package:flutter/material.dart';

Row flatInfoDivider({required BuildContext context, String text = ''}) {
  return Row(
    children: [
      Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Divider(
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ],
  );
}
