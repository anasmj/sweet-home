import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';

Future<void> showElectricityUnitDialog(
    {required BuildContext context, required UnitType unitType}) async {
  GlobalKey<FormState>? formKey = GlobalKey();
  TextEditingController unitController = TextEditingController();
  Flat? flat = context.read<FlatViewModel>().userFlat;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      // final viewModel = context.read<RenterViewModel>();
      final flatViewModel = context.watch<FlatViewModel>();
      return AlertDialog(
        iconColor: Colors.red,
        icon: const Icon(
          Icons.gas_meter_outlined,
          size: 40,
        ),
        title: Text(unitType == UnitType.present
            ? 'বর্তমান ইউনিট ঠিক করুন'
            : 'পূর্বের ইউনিট ঠিক করুন'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // title: Text(title),

        content: Form(
          key: formKey,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: unitController,
            validator: (value) {
              if (value!.isEmpty) return 'হিসাবের জন্য তথ্যটি প্রয়োজন';
              if (double.parse(value) <= 0) {
                return 'তথ্যটি সঠিক নয়';
              }

              switch (unitType) {
                case UnitType.present:
                  if (double.parse(value) <= flat!.previousMeterReading!) {
                    return 'পূর্বের রিডিং এর চেয়ে কম';
                  }
                  break;
                case UnitType.previous:
                  if (flat!.presentMeterReading != null) {
                    if (double.parse(value) > flat.presentMeterReading!) {
                      return 'বর্তমান রিডিং এর চেয়ে বেশি';
                    }
                  }
                  break;
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
                flatViewModel.setMeterReading =
                    double.parse(unitController.text);

                flatViewModel.updateFlatField(
                    fieldName: unitType == UnitType.present
                        ? 'presentMeterReading'
                        : 'previousMeterReading',
                    newValue: flatViewModel.meterReading,
                    updateTime: DateTime.now());

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
