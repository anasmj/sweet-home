import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/view_models/home_service_charge_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required GlobalKey<FormState> nameKey,
    required GlobalKey<FormState> amountKey,
    required TextEditingController nameController,
    required TextEditingController amountController,
    required BuildContext sheetContext,
  })  : _nameKey = nameKey,
        _amountKey = amountKey,
        _nameController = nameController,
        _amountController = amountController,
        _sheetContext = sheetContext;

  final GlobalKey<FormState> _nameKey;
  final GlobalKey<FormState> _amountKey;
  final BuildContext _sheetContext;
  final TextEditingController _nameController;
  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<HomeServiceChargeListViewModel>(context, listen: false);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      )),
      onPressed: () async {
        if (_nameKey.currentState!.validate() &&
            _amountKey.currentState!.validate()) {
          Response response = await provider.addNewServiceCharge(
            title: _nameController.text,
            amount: double.parse(_amountController.text),
          );
          if (response.code == 200) {
            AppWidget.showSnackBarWithMsg(msg: 'খরচটি যুক্ত করা হয়েছে');

            provider.readServiceCharges();
          } else {
            AppWidget.showSnackBarWithMsg(msg: 'একটু পরে আবার চেষ্টা করুন');
          }

          // ignore: use_build_context_synchronously
          Navigator.of(_sheetContext).pop();
        }
      },
      child: const Text(
        'যুক্ত করি',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
