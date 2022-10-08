import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';

import '../models/flat_model.dart';

import '../models/response.dart';
import '../providers/bills_provider.dart';
import '../providers/current_home.dart';
import '../providers/selected_flat_view_model.dart';
import '../../prev/providers/monthly_record_provider.dart';
import '../repositories/flat_services.dart';
import '../view_models/renter_opening_page_view_model.dart';

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

  //TODO: make this bottom shit usable for all
  static Future getModalSheet(
      {required BuildContext context, required Widget modalSheetContent}) {
    final Color modalSheetBgDark = Colors.grey.shade900;
    const Color modalSheetBgLight = Colors.white;
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

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

  static TextSpan get taka => TextSpan(
        text: '৳',
        style: TextStyle(
          color: Colors.red[900],
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      );

  static Future<void> showElectricityUnitDialog(
      {required BuildContext context}) async {
    GlobalKey<FormState>? formKey = GlobalKey();
    TextEditingController unitController = TextEditingController();
    Flat? flat = context.read<SelectedFlatVuewModel>().selectedFlat;
    String homeId = context.read<CurrentHomeProvider>().currentHome!.homeId;
    RenterOpeningViewModel providerRead =
        context.read<RenterOpeningViewModel>();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          iconColor: Colors.red,
          icon: const Icon(
            Icons.gas_meter_outlined,
            size: 40,
          ),
          title: const Text('বর্তমান ইউনিট দেয়া হয়নি'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // title: Text(title),

          content: Form(
            key: formKey,
            child: TextFormField(
              controller: unitController,
              validator: (value) {
                if (value!.isEmpty) return 'হিসাবের জন্য তথ্যটি প্রয়োজন';
                if (double.parse(value) <= 0) {
                  return 'তথ্যটি সঠিক নয়';
                }
                if (double.parse(value) <= flat!.previousMeterReading!) {
                  return 'মিটারের রিডিং আগের মাসের থেকে কম';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('ইউনিট'),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'এখন নয়',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'ঠিক আছে',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  providerRead.setMeterReading =
                      double.parse(unitController.text);
                  Response res = await FlatService().updateFlat(
                    homeId: homeId,
                    flatName: flat!.flatName,
                    fieldName: 'currentMeterReading',
                    newValue: providerRead.meterReading,
                  );
                  if (res.code == 200) {
                    // ignore: use_build_context_synchronously
                    context.read<BillsProvider>().setCurrentReading =
                        providerRead.meterReading ?? 0;
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
