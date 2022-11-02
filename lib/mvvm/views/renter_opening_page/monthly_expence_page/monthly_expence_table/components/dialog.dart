import 'package:flutter/material.dart';

Future<dynamic> noPrevReadingAlert(BuildContext context, String msg) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Colors.red,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(msg),
        ],
      ),
    ),
  );
}
