import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/utils/form_validators.dart';
import 'package:sweet_home/mvvm/views/flat_info_page/service_charge/components/add_button.dart';

class AddExpenceSheetContent extends StatelessWidget {
  AddExpenceSheetContent({super.key});
  final GlobalKey<FormState> _nameKey = GlobalKey();
  final GlobalKey<FormState> _amountKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'খরচ যুক্ত',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Form(
              key: _nameKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                validator: FormValidators.checkEmpty,
                controller: _nameController,
                decoration: const InputDecoration(
                  label: Text('খরচের নাম'),
                  hintText: 'eg. নিরাপত্তা',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _amountKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: FormValidators.checkNonZero,
                decoration: const InputDecoration(
                    label: Text('খরচের পরিমাণ'), prefixText: '৳ '),
              ),
            ),
            const SizedBox(height: 20),
            AddButton(
              nameKey: _nameKey,
              amountKey: _amountKey,
              nameController: _nameController,
              amountController: _amountController,
              sheetContext: context,
            ),
          ],
        ),
      ),
    );
  }
}
