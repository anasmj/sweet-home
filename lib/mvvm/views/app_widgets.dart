import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';

class AppWidget {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      // msg: "ফ্ল্যাটটি খালি নেই",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey.shade700.withOpacity(0.95),
      // backgroundColor: Colors.grey.shade50,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

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

  static SnackBar showSnackBarWithMsg({required String msg}) => SnackBar(
        content: Text(msg),
      );
  static Future getModalSheet({
    required BuildContext context,
    required Widget modalSheetContent,
  }) {
    final Color modalSheetBgDark = Colors.grey.shade900;
    const Color modalSheetBgLight = Colors.white;
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: isDark ? modalSheetBgDark : modalSheetBgLight,
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

  static Future<void> confirmDialog(
      {required BuildContext context,
      required String msg,
      String title = '',
      VoidCallback? onAction}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(title),
          content: Text(
            msg,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'না',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: onAction,
              child: const Text(
                'হ্যাঁ',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        );
      },
    );
  }

  static TextSpan get taka => TextSpan(
        text: '৳',
        style: TextStyle(
          color: Colors.red[900],
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      );

  // static Future<void> showElectricityUnitDialog(
  //     {required BuildContext context, required MeterUnit meterUnit}) async {
  //   GlobalKey<FormState>? formKey = GlobalKey();
  //   TextEditingController unitController = TextEditingController();
  //   Flat? flat = context.read<SelectedFlatProvider>().selectedFlat;
  //   String homeId = context.read<CurrentHomeProvider>().currentHome!.homeId;
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       final providerRead = context.read<RenterViewModel>();
  //       return AlertDialog(
  //         iconColor: Colors.red,
  //         icon: const Icon(
  //           Icons.gas_meter_outlined,
  //           size: 40,
  //         ),
  //         title: Text(meterUnit == MeterUnit.present
  //             ? 'বর্তমান ইউনিট ঠিক করুন'
  //             : 'পূর্বের ইউনিট ঠিক করুন'),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         // title: Text(title),

  //         content: Form(
  //           key: formKey,
  //           child: TextFormField(
  //             autovalidateMode: AutovalidateMode.onUserInteraction,
  //             controller: unitController,
  //             validator: (value) {
  //               if (value!.isEmpty) return 'হিসাবের জন্য তথ্যটি প্রয়োজন';
  //               if (double.parse(value) <= 0) {
  //                 return 'তথ্যটি সঠিক নয়';
  //               }

  //               switch (meterUnit) {
  //                 case MeterUnit.present:
  //                   if (double.parse(value) <= flat!.previousMeterReading!) {
  //                     return 'পূর্বের রিডিং এর চেয়ে কম';
  //                   }
  //                   break;
  //                 case MeterUnit.previous:
  //                   if (flat!.currentMeterReading != null) {
  //                     if (double.parse(value) > flat.currentMeterReading!) {
  //                       return 'বর্তমান রিডিং এর চেয়ে বেশি';
  //                     }
  //                   }
  //                   break;
  //               }
  //               return null;
  //             },
  //             keyboardType: TextInputType.number,
  //             decoration: const InputDecoration(
  //               label: Text('ইউনিট'),
  //             ),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text(
  //               'এখন নয়',
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text(
  //               'ঠিক আছে',
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             onPressed: () async {
  //               if (formKey.currentState!.validate()) {
  //                 providerRead.setMeterReading =
  //                     double.parse(unitController.text);
  //                 Response res = await FlatService().updateFlat(
  //                   homeId: homeId,
  //                   flatName: flat!.flatName,
  //                   fieldName: 'currentMeterReading',
  //                   newValue: providerRead.meterReading,
  //                 );
  //                 if (res.code == 200) {
  //                   // ignore: use_build_context_synchronously
  //                   context.read<RenterViewModel>().setCurrentReading =
  //                       providerRead.meterReading ?? 0;
  //                 }
  //                 // ignore: use_build_context_synchronously
  //                 Navigator.of(context).pop();
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
