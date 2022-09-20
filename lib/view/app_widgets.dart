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

  static Future getModalSheet(
      {required BuildContext context,
      required bool isDark,
      required Widget modalSheetContent}) {
    final Color modalSheetBgDark = Colors.grey.shade900;
    const Color modalSheetBgLight = Colors.white;

    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: isDark ? modalSheetBgDark : modalSheetBgLight,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return modalSheetContent;
        });
  }

  static Future<void> showConfirmDialog(
      {required BuildContext context,
      required String msg,
      String title = ''}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // title: Text(title),

          content: Text(
            msg,
            textAlign: TextAlign.center,
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
}
