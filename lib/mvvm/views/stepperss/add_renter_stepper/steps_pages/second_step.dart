import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';
import '../../../../view_models/new_renter_view_model.dart';
import '../../components/stepper_textfield.dart';
import 'components/location_radio.dart';

// ignore: must_be_immutable
class AddressStep extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final provider = Provider.of<NewRenterViewModel>(context);
    return Form(
      //Nothnig to validate
      child: Column(
        children: [
          StepperTextField(
            label: "পূর্বের ঠিকানা",
            textEditingController: provider.previousLocationController,
            // textEditingController: previousAddressController,
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
            textEditingController: provider.villageController,
            // textEditingController: vilageController,
          ),
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const LocationRadio(),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: StepperTextField(
                  textEditingController: provider.isThanaSelected
                      ? provider.thanaController
                      : provider.unionController,
                  // textEditingController: unionController,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          StepperTextField(
            label: 'উপজেলা',
            textEditingController: provider.subDistrictController,

            // textEditingController: subDistrictController,
          ),
          const SizedBox(
            height: 10,
          ),
          StepperTextField(
            label: 'জেলা',
            textEditingController: provider.districtController,

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
          color: context.watch<ThemeProvider>().isDarkMode
              ? Colors.grey.shade400
              : Colors.grey.shade800,
        ),
      )
    ]);
  }

  Widget buildChips() => Wrap(
        children: const [
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
