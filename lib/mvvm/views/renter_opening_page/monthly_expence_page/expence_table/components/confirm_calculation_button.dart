import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/dialogs.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'dialogs.dart';

// ignore: must_be_immutable
class ConfirmCalculationButton extends StatelessWidget {
  const ConfirmCalculationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlatViewModel flatViewModel = context.watch<FlatViewModel>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: !flatViewModel.isLoading,
          child: Text(
            '* হিসাবটি আপডেট করতে ক্লিক করুন',
            style: TextStyle(color: Colors.red.shade700),
          ),
        ),
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minWidth: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          color: Theme.of(context).secondaryHeaderColor,
          disabledColor: Colors.grey,
          onPressed: flatViewModel.userFlat!.renter != null
              ? () async {
                  final navigator = Navigator.of(context);
                  if (flatViewModel.electricBill == null) {
                    notReadyDialog(context);
                  } else {
                    AppDialog().showLoadingDialog(
                        context: context, msg: 'আপডেট করা হচ্ছে');

                    bool status = await flatViewModel.confirmMonthlyExpence();

                    // var status = true;
                    navigator.pop(); //popping loading dialog
                    if (status) {
                      // ignore: use_build_context_synchronously
                      showMonthlyCostConfirmDialog(context);
                      await Future.delayed(const Duration(seconds: 2));
                      navigator.pop(); //poping confirm dialog;
                    }
                    if (!status) {
                      AppWidget.showSnackBarWithMsg(
                          msg: 'কোনও একটি সমস্যা হয়েছে');
                    }
                  }
                }
              : null,
          child: flatViewModel.isLoading
              ? loadingWidget()
              : Text(
                  'হিসাবটি নিশ্চিত করি',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
        ),
      ],
    );
  }

  SizedBox loadingWidget() {
    return const SizedBox(
        height: 22, width: 22, child: CircularProgressIndicator());
  }
}
