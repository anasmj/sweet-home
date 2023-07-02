import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/stepper.textfield/stepper_textfield.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/modules/add_renter_stepper/provider/new.renter.provider.dart';

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
    final notifier = ref.watch(newRenterProvider.notifier);
    return Form(
      //Nothnig to validate
      child: Column(
        children: [
          StepperTextField(
            label: "পূর্বের ঠিকানা",
            onChanged: notifier.onAddressChanged,
          ),
          StepperTextField(
            label: "স্থায়ী ঠিকানা",
            onChanged: notifier.onPermanentAddressChanged,
          ),
          height10,
          height10,
        ],
      ),
    );
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
