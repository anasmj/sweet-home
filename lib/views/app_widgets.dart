import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

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
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 2,
          child: TextField(
            style: TextStyle(
              color: context.watch<ThemeProvider>().isDarkMode
                  ? Colors.white
                  : Colors.grey.shade800,
              fontSize: 18,
            ),
            cursorColor: context.watch<ThemeProvider>().isDarkMode
                ? Colors.white
                : Colors.grey.shade700,
            maxLines: 1,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.only(top: 10),
              hintText: 'খোঁজ করুন',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      );

  static SnackBar snackBarContent({required String msg}) => SnackBar(
        content: Text(msg),
      );
}
