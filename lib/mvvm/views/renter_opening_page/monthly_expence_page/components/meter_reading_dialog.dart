import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/view_models/renter_view_model.dart';

Future<void> showElectricityUnitDialog(
    {required BuildContext context, required UnitType unitType}) async {
  GlobalKey<FormState>? formKey = GlobalKey();
  TextEditingController unitController = TextEditingController();
  Flat? flat = context.read<SelectedFlatProvider>().selectedFlat;
  String homeId = context.read<CurrentHomeProvider>().currentHome!.homeId;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      final viewModel = context.read<RenterViewModel>();
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
                  if (flat!.currentMeterReading != null) {
                    if (double.parse(value) > flat.currentMeterReading!) {
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
                viewModel.setMeterReading = double.parse(unitController.text);

                Response res = await FlatService().updateFlat(
                  homeId: homeId,
                  flatName: flat!.flatName,
                  fieldName: unitType == UnitType.present
                      ? 'currentMeterReading'
                      : 'previousMeterReading',
                  newValue: viewModel.meterReading,
                  updateTime: DateTime.now(),
                );
                if (res.code == 200) {
                  // ignore: use_build_context_synchronously
                  // context.read<RenterViewModel>().setCurrentReading =
                  //     providerRead.meterReading ?? 0;
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
