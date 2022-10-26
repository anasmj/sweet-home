import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/form_validators.dart';
import 'package:sweet_home/mvvm/view_models/renter_opening_page_view_model.dart';

class PaymentTextField extends StatelessWidget {
  const PaymentTextField({
    super.key,
  });
  final double _width = 140;
  final double _fontSize = 24;
  final double _cursorHeight = 28;
  final double _fromLeft = 12.0;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RenterOpeningViewModel>(context);
    return Form(
      key: context.watch<RenterOpeningViewModel>().paymentKey,
      child: SizedBox(
        width: _width,
        child: TextFormField(
          controller: viewModel.paymentController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormValidators.checkNonZero,
          style: TextStyle(fontSize: _fontSize),
          cursorHeight: _cursorHeight,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 0.01),
            contentPadding: EdgeInsets.only(left: _fromLeft),
            prefixStyle: TextStyle(fontSize: _fontSize),
            prefixText: '৳ ',
          ),
        ),
      ),
    );
  }
}
