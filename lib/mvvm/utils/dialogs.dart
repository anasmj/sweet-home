import 'package:flutter/material.dart';

class AppDialog {
  final RoundedRectangleBorder dialogBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  Future<void> showLoadingDialog(
      {required BuildContext context, required String msg}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: dialogBorder,
          content: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              const SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator()),
              const SizedBox(width: 20),
              Text(msg),
            ],
          ),
        );
      },
    );
  }
}
