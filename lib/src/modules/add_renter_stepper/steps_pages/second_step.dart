import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/stepper.textfield/stepper_textfield.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/providers/text.controller.provider.dart';

// ignore: must_be_immutable
class AddressStep extends ConsumerWidget {
  AddressStep({
    Key? key,
  }) : super(key: key);
  int numOfMember = 2;
  final addressFormKey = GlobalKey<FormState>();

  final previousAddressController = TextEditingController();
  final permanentAddressController = TextEditingController();
  final vilageController = TextEditingController();
  final unionController = TextEditingController();
  final subDistrictController = TextEditingController();
  final districtController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    return Form(
      //Nothnig to validate
      child: Column(
        children: [
          StepperTextField(
            label: "পূর্বের ঠিকানা",
            textEditingController:
                ref.watch(tecProvider(Field.renterPrevAddress)),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          permanentAddressDivider(context),
          const SizedBox(
            height: 10,
          ),
          StepperTextField(
              label: 'গ্রাম',
              textEditingController:
                  ref.watch(tecProvider(Field.renterVillage))),
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              // const LocationRadio(),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: StepperTextField(
                  textEditingController:
                      ref.watch(tecProvider(Field.renterThana)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          StepperTextField(
            label: 'উপজেলা',
            textEditingController:
                ref.watch(tecProvider(Field.renterSubDistrict)),

            // textEditingController: subDistrictController,
          ),
          const SizedBox(
            height: 10,
          ),
          StepperTextField(
            label: 'জেলা',
            textEditingController: ref.watch(tecProvider(Field.renterDistrict)),

            // textEditingController: districtController,
          ),
        ],
      ),
    );
  }

  Row permanentAddressDivider(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        'স্থায়ী ঠিকানা',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Divider(
          color: Colors.grey.shade800,
        ),
      )
    ]);
  }
}

class RenterChips extends StatelessWidget {
  const RenterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      children: [
        ChoiceChip(
          selected: true,
          elevation: 3,
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('1A'),
          ),
          label: Text('আশরাফুল আলম'),
        ),
        Chip(
          elevation: 3,
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('1B'),
          ),
          label: Text('রবিউল ইসলাম'),
        ),
        Chip(
          elevation: 3,
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('2A'),
          ),
          label: Text('মাইনুল হোসেন'),
        ),
        Chip(
          elevation: 3,
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('2B'),
          ),
          label: Text('সাইফুল'),
        ),
      ],
    );
  }
}
