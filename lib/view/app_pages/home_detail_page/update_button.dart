import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/services/database_service/home_crud.dart';

import '../../../providers/current_home.dart';
import '../../app_widgets.dart';

// ignore: must_be_immutable
class UpdateButton extends StatelessWidget {
  UpdateButton({
    Key? key,
    required this.homeId,
    required this.editFormKey,
    required this.dbFieldName,
  }) : super(key: key);
  String dbFieldName;
  String homeId;
  final GlobalKey<FormState> editFormKey;

  String buttonText = 'সেভ';

  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider provider = context.read<CurrentHomeProvider>();
    String updateWith = provider.displayTextController.text;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
      ),
      onPressed: () {
        if (editFormKey.currentState!.validate()) {
          // HomeCrud().updatefield(
          //     homeId: homeId, field: dbFieldName, newValue: updateWith);
        } else {
          AppWidget.showToast('আপডেট করা সম্ভব হয়নি');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(buttonText,
            style: const TextStyle(
              fontSize: 18,
            )),
      ),
    );
  }
}
