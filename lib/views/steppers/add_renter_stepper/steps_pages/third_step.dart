import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/views/styling/app_icons.dart';
import '../../../../providers/newrenter_step_provider.dart';
import 'components/nid_Image_containers.dart';

class ThirdStepPage extends StatelessWidget {
  ThirdStepPage({super.key});
  final advanceAmountTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    NewRenterStepProvider provider =
        Provider.of<NewRenterStepProvider>(context);

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
            Checkbox(
              value: provider.advanceStatus,
              onChanged: (value) => provider.setAdvanceStatus(value!),
            ),
            const Text('অগ্রীম'),
            const SizedBox(
              width: 20,
            ),
            getAdvanceTextField(context, advanceAmountTextController),
          ],
        ),
      ],
    );
  }

  Widget getAdvanceTextField(
      BuildContext context, TextEditingController controller) {
    final provider = context.watch<NewRenterStepProvider>();
    return SizedBox(
      width: 120,
      height: 40,
      child: TextFormField(
        controller: controller,
        enabled: provider.advanceStatus,
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
              color: provider.advanceStatus
                  ? Colors.black.withOpacity(0.80)
                  : Colors.black.withOpacity(0.40),
              image: AssetImage(
                AppIcons.takaUrl,
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
