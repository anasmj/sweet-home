import 'package:flutter/material.dart';

Future<void> showNamePicker(
    {required BuildContext context, String title = ''}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('প্রদানকারীর নাম'),
        content: TextFormField(
          decoration: const InputDecoration(),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'ঠিক আছে',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
