import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';
import '../../../../view_models/home_stepper_view_model.dart';
import '../../../../utils/form_validators.dart';
import '../../components/stepper_textfield.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _secondPageFormKey = GlobalKey<FormState>();

  bool? gasChecked = false;
  bool? waterChecked = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeStepperProviderViewModel>(context);
    provider.secondPageFormKey = _secondPageFormKey;

    TextStyle? formTextStyle = Theme.of(context).textTheme.titleMedium;
    return Form(
      key: provider.secondPageFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'বিলসমূহ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Divider(
            color: context.watch<ThemeProvider>().isDarkMode
                ? Colors.white
                : Colors.grey[900],
          ),
          const SizedBox(
            height: 20,
          ),
          RentAmountField(formTextStyle: formTextStyle, provider: provider),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'গ্যাস',
                  style: formTextStyle,
                ),
              ),
              Expanded(
                child: StepperTextField(
                  textEditingController: provider.gasController,
                  validationFunciton: FormValidators.checkGasBill,
                  isNumeric: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'পানি',
                  style: formTextStyle,
                ),
              ),
              Expanded(
                child: StepperTextField(
                  textEditingController: provider.waterController,
                  validationFunciton: FormValidators.checWaterBill,
                  isNumeric: true,
                ),
              ),
            ],
          ),

          // GasField(provider: provider),
          // WaterBillField(provider: provider),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class RentAmountField extends StatelessWidget {
  const RentAmountField({
    super.key,
    required this.formTextStyle,
    required this.provider,
  });

  final TextStyle? formTextStyle;
  final HomeStepperProviderViewModel provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(text: 'ভাড়া', style: formTextStyle),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: StepperTextField(
            textEditingController: provider.rentController,
            validationFunciton: FormValidators.checkRentAmount,
            isNumeric: true,
          ),
        ),
      ],
    );
  }
}
