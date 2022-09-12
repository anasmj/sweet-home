import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/home_model.dart';
import '../models/response.dart';
import '../providers/current_home.dart';
import '../services/database_service/home_crud.dart';
import '../view/app_widgets.dart';

onHomeDeleted(BuildContext context) {
  Home? currentHome = context.read<CurrentHomeProvider>().getCurrentHome;
  if (currentHome != null) {
    var home;
    Response response = HomeCrud().deleteHome(home.homeId);
    if (response.code != 200) {
      AppWidget.snackBarContent(msg: 'বাড়ীটি ডিলিট করা সম্ভব হয়নি');
    }
    AppWidget.showToast('বাড়ীটি মুছে ফেলা হয়েছে');
    context.read<CurrentHomeProvider>().setCurrentHome(null);
    //close drawer
    Navigator.of(context).pop();
  }
}

//FUNCTION TO UPDATE TEXTFIELD OF HOME
onUpdateField(
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
    providerRead.setCurrentHome(null);
    Navigator.of(context).pop();
  } else {
    AppWidget.showToast('আপডেট করা সম্ভব হয়নি');
  }
}

String getFirebaseFieldName({required String title}) {
  final displayFieldToDbField = {
    //app field | DB fields
    'বাড়ীর নাম': 'Home Name',
    'ভাড়া': 'Rent Amount',
    'ঠিকানা': 'Location',
    'তলা': 'Floor',
    'ফ্লোরে ফ্ল্যাট সংখ্যা': 'Flat Per Floor',
    'গ্যাস': 'Gas Bill',
    'পানি': 'Water Bill',
    // 'অন্যান্য' : 'Others'
  };

  String selectedFirebaseField;
  selectedFirebaseField = displayFieldToDbField[title] ?? 'Not found';

  return selectedFirebaseField;
}
