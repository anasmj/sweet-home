import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/providers/transaction_provider.dart';

import 'package:sweet_home/view/resources/app_icons.dart';

class PaymentInputTextField extends StatelessWidget {
  const PaymentInputTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: Form(
        key: context.watch<TransactionProvider>().paymentKey,
        child: TextFormField(
          controller: context.read<TransactionProvider>().paymentController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'তথ্যটি সঠিক নয়';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 25),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 20,
              maxHeight: 30,
              minWidth: 20,
              maxWidth: 30,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image(
                color: !context.watch<ThemeProvider>().isDarkMode
                    ? Colors.black.withOpacity(0.9)
                    : Colors.white,
                height: 10,
                image: AssetImage(
                  AppIcons.takaUrl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
