import 'package:flutter/material.dart';

class AddExpenceSheetContent extends StatelessWidget {
  const AddExpenceSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            TextFormField(
              decoration: const InputDecoration(label: Text('খরচের বিবরণ')),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  label: Text('খরচের পরিমাণ'), prefixText: '৳ '),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('যুক্ত করি'),
            ),
          ],
        ),
      ),
    );
  }
}
