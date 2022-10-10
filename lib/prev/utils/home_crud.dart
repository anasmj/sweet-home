import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../mvvm/models/response.dart';
import '../../mvvm/services/home_services.dart';
import '../../mvvm/models/home_model.dart';

import '../../mvvm/providers/current_home.dart';

import '../../mvvm/views/app_widgets.dart';

onHomeDeleted(BuildContext context) async {
  Home? currentHome = context.read<CurrentHomeProvider>().currentHome;
  if (currentHome != null) {
    var homeId = currentHome.homeId;
    Response response = HomeCrud().deleteHome(homeId);
    //trying to find other homs
    context.read<CurrentHomeProvider>().setCurrentHome = null;
    List<Home> homeList = await HomeCrud().getAllHome();
    if (homeList.isNotEmpty) {
      // ignore: use_build_context_synchronously
      context.read<CurrentHomeProvider>().setCurrentHome = homeList.first;
    }
    if (response.code != 200) {
      AppWidget.snackBarContent(msg: 'বাড়ীটি ডিলিট করা সম্ভব হয়নি');
    }
    AppWidget.showToast('বাড়ীটি মুছে ফেলা হয়েছে');

    // context.read<CurrentHomeProvider>().setCurrentHome(null);
    //close drawer

    Navigator.of(context).pop();
  }
}

//FUNCTION TO UPDATE TEXTFIELD OF HOME
void onUpdateField(
    {required BuildContext context,
    required dynamic title,
    required Home home,
    bool isDouble = false,
    bool isInt = false}) {
  GlobalKey<FormState> formKey =
      context.read<CurrentHomeProvider>().editFormKey;
  dynamic castInCorrectType(
      {required String value, bool isDouble = false, bool isInt = false}) {
    if (isDouble) return double.parse(value);
    if (isInt) return int.parse(value);
    return value;
  }

  //updating the field here
  if (formKey.currentState!.validate()) {
    CurrentHomeProvider providerWatch = context.read<CurrentHomeProvider>();

    CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();
    HomeCrud().updatefield(
      homeId: home.homeId,
      field: getFirebaseFieldName(title: title),
      newValue: castInCorrectType(
        value: providerWatch.displayTextController.text,
        isDouble: isDouble,
        isInt: isInt,
      ),
    );
    providerRead.setCurrentHome = null;
    Navigator.of(context).pop();
  } else {
    AppWidget.showToast('আপডেট করা সম্ভব হয়নি');
  }
}

String getFirebaseFieldName({required String title}) {
  final displayFieldToDbField = {
    //app field | DB fields
    'বাড়ীর নাম': 'homeName',
    'ভাড়া': 'rentAmount',
    'ঠিকানা': 'location',
    'তলা': 'Floor',
    'ফ্লোরে ফ্ল্যাট সংখ্যা': 'flatPerFloor',
    'গ্যাস': 'gasBill',
    'পানি': 'waterBill',
    // 'অন্যান্য' : 'Others'
  };

  String selectedFirebaseField;
  selectedFirebaseField = displayFieldToDbField[title] ?? 'Not found';

  return selectedFirebaseField;
}
