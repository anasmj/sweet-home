import 'package:flutter/material.dart';
import 'package:sweet_home/src/model/response.dart';
import 'package:sweet_home/src/utils/formatter.dart';

// ignore: must_be_immutable
class TransactionSubmitButton extends StatelessWidget {
  TransactionSubmitButton({
    super.key,
    required this.transactionPageContext,
  });

  final recordId = Formatter.toYearMonth(DateTime.now());
  BuildContext transactionPageContext;
  final String buttonText = 'বুঝে পেলাম';
  Response response = Response();
  @override
  Widget build(BuildContext context) {
    // final provider = context.read<TransactionProvider>();

    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      minWidth: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      color: Theme.of(context).secondaryHeaderColor,
      disabledColor: Colors.grey,
      onPressed: () async {},
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
