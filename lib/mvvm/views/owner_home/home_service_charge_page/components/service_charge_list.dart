import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/service_charges.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/form_validators.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/home_service_charge_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'long_press_sheet_options.dart';
import '../../../shared_widgets/edit_modal_sheet.dart';

class ServiceChargeList extends StatelessWidget {
  const ServiceChargeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeServiceChargeListViewModel>(context);
    //TODO: HANDLE EXCEPTION IF USER TRY TO UPDATE WITH NULL VALUE
    return ListView(
      children: provider.serviceChargeList.map((item) {
        return ListTile(
          onTap: () {
            AppWidget.getModalSheet(
              context: context,
              modalSheetContent: EditModalSheet(
                scope: Scope.home,
                controller: provider.chargeEditingController,
                formKey: provider.chargeEditingFormKey,
                onUpdated: () async {
                  Navigator.of(context).pop();
                  Response? res = await provider.updateHomeServiceCharge(
                      oldObj: item,
                      newObj: Utility(
                          purpose: item.purpose,
                          amount: double.parse(
                              provider.chargeEditingController.text)));
                  if (res?.code == null) {
                    AppWidget.showSnackBarWithMsg(msg: 'আপডেট করা সম্ভব হয়নি');
                  }

                  if (res?.code != 200) return;
                  AppWidget.showToast('আপডেট করা হয়েছে');
                  provider.chargeEditingController.clear();
                  await provider.readServiceCharges();
                },
                validationFunciton: FormValidators.checkEmpty,
                sheetTitle: item.purpose,
                textFieldLabel:
                    Formatter.toBn(value: item.amount, includeSymbol: true),
              ),
            );
          },
          onLongPress: () {
            AppWidget.getModalSheet(
              context: context,
              modalSheetContent: LongPressSheetOptions(
                onRemoveRequest: () {
                  Navigator.of(context).pop();
                  provider.setServiceCharge = null;
                  AppWidget.confirmDialog(
                    context: context,
                    msg: 'তথ্যটি সকল ফ্ল্যাট থেকে মুছে ফেলা হবে',
                    title: 'আপনি কি নিশ্চিত? ',
                    onAction: () async {
                      Navigator.of(context).pop();
                      Response res = await provider.deleteServiceCharge(
                          serviceCharge: item);
                      if (res.code != 200) {
                        AppWidget.showSnackBarWithMsg(
                            msg: 'একটু পরে আবার চেষ্টা করুন ');
                      } else {
                        AppWidget.showSnackBarWithMsg(
                            msg: 'খরচটি সরিয়ে ফেলা হয়েছে ');
                        await provider.readServiceCharges();
                      }
                    },
                  );
                },
              ),
            );
          },
          title: Text(item.purpose),
          subtitle: Text(
            Formatter.toBn(
              value: item.amount,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // subtitle: Text('৳ ${item.amount.toStringAsFixed(1)}'),
        );
      }).toList(),
    );
  }
}
