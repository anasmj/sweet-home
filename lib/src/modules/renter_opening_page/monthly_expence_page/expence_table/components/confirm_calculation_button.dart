import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/flats/provider/selected.flat.provider.dart';

// ignore: must_be_immutable
class ConfirmCalculationButton extends ConsumerWidget {
  const ConfirmCalculationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final flat = ref.watch(selectedFlatProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: true,
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
          onPressed: flat?.renter != null ? () async {} : null,
          child: Text(
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
