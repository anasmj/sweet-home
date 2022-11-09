import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/monthly_record.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
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
                  if (flatViewModel.total == null) {
                    notReadyDialog(context);
                  } else {
                    var status = await flatViewModel.confirmMonthlyExpence();
                    if (status == true) {
                      // ignore: use_build_context_synchronously
                      showMonthlyCostConfirmDialog(context);
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
