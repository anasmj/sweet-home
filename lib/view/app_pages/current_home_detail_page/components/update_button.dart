import 'package:flutter/material.dart';

import '../../../app_widgets.dart';

// ignore: must_be_immutable
class UpdateButton extends StatelessWidget {
  UpdateButton({Key? key, required this.editFormKey, required this.fieldName})
      : super(key: key);

  String fieldName;
  final GlobalKey<FormState> editFormKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
      ),
      onPressed: () {
        print(fieldName);

        if (editFormKey.currentState!.validate()) {
          //update in db
          // updateField(home.homeId);
        } else {
          AppWidget.showToast('আপডেট করা সম্ভব হয়নি');
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Text('তথ্য পরিবর্তন',
            style: TextStyle(
              fontSize: 18,
            )),
      ),
    );
  }
}
