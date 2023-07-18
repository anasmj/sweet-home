import 'package:flutter/material.dart';

import 'payer_name_taker.dart';

// ignore: must_be_immutable
class PayerNameButton extends StatelessWidget {
  PayerNameButton({
    Key? key,
    required this.transactionPageContext,
  }) : super(key: key);
  BuildContext transactionPageContext;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        FocusScope.of(transactionPageContext).unfocus();
        showNamePicker(context: context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'jjhj',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.edit,
            size: 12,
          )
        ],
      ),
    );
  }
}
