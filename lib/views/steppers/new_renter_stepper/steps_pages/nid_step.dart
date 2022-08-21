import 'package:flutter/material.dart';
import 'package:rent_home/views/app_icons.dart';

import 'components/advance_payment_checkbox.dart';
import 'components/nid_Image_containers.dart';

class NidStep extends StatelessWidget {
  const NidStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('NID কার্ড-এর ছবি যুক্ত করুন'),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: const [
            Expanded(child: FrontNid()),
            SizedBox(
              width: 10,
            ),
            Expanded(child: BackNid()),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AdvancePaymentCheckbox(),
            const Text('অগ্রীম'),
            const SizedBox(
              width: 20,
            ),
            getAdvanceTextField(context),
          ],
        ),
      ],
    );
  }

  Widget getAdvanceTextField(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 40,
      child: TextFormField(
        // enabled: false, //! enable only when checkbox is selected
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        cursorHeight: 22,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 18,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4),
            child: Image(
              color: Colors.black.withOpacity(0.80),
              image: AssetImage(
                AppIcons().takaUrl,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
