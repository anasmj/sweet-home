import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppWidget {
  static void showToast(String message) => Fluttertoast.showToast(
        msg: message,
        // msg: "ফ্ল্যাটটি খালি নেই",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white.withOpacity(0.9),
        // backgroundColor: Colors.grey.shade50,
        textColor: Colors.black,
        fontSize: 14.0,
      );

  static Widget appSearchBar({required BuildContext context}) => SizedBox(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: searchBoxBorder(),
            filled: true,
            hintText: ' খোঁজ করুন',
            prefixIcon: const Icon(
              Icons.search,
            ),
          ),
          maxLines: 1,
        ),
      );

  static OutlineInputBorder searchBoxBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    );
  }

  static SnackBar snackBarContent({required String msg}) => SnackBar(
        content: Text(msg),
      );
}
