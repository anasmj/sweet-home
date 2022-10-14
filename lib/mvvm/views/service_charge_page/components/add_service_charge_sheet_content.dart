import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/utils/form_validators.dart';
import 'package:sweet_home/mvvm/view_models/service_charge_list_view_mode.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';

class AddExpenceSheetContent extends StatelessWidget {
  AddExpenceSheetContent({super.key});
  final GlobalKey<FormState> _nameKey = GlobalKey();
  final GlobalKey<FormState> _amountKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ServiceChargeListViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'খরচ যুক্ত',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Form(
              key: _nameKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                validator: FormValidators.checkEmpty,
                controller: _nameController,
                decoration: const InputDecoration(
                  label: Text('খরচের নাম'),
                  hintText: 'eg. নিরাপত্তা',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _amountKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: FormValidators.checkNonZero,
                decoration: const InputDecoration(
                    label: Text('খরচের পরিমাণ'), prefixText: '৳ '),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              onPressed: () async {
                if (_nameKey.currentState!.validate() &&
                    _nameKey.currentState!.validate()) {
                  Response response = await provider.addNewServiceCharge(
                    title: _nameController.text,
                    amount: double.parse(_amountController.text),
                  );
                  if (response.code == 200) {
                    AppWidget.showSnackBarWithMsg(msg: 'খরচটি যুক্ত করা হয়েছে');

                    provider.readAllServiceCharges();
                  } else {
                    AppWidget.showSnackBarWithMsg(
                        msg: 'একটু পরে আবার চেষ্টা করুন');
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                }
              },
              child: const Text('যুক্ত করি'),
            ),
          ],
        ),
      ),
    );
  }
}
