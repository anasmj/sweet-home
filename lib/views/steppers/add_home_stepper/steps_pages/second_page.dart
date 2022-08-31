import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/views/steppers/shared_components/stepper_textfield.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});

  final rentController = TextEditingController();
  final electricityController = TextEditingController();
  final gasController = TextEditingController();
  final waterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'বিলসমূহ',
            style: Theme.of(context).textTheme.headline6,
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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(
                          text: 'ভাড়া', style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: '*', style: TextStyle(color: Colors.red[900])),
                    ]),
              ),
            ),
            Expanded(
              child: StepperTextField(
                textEditingController: rentController,
                isNumber: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(
                          text: 'বিদ্যুৎ',
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: '*', style: TextStyle(color: Colors.red[900])),
                    ]),
              ),
            ),
            Expanded(
                child: StepperTextField(
                    textEditingController: electricityController)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('গ্যাস'),
            ),
            Expanded(
                child: StepperTextField(textEditingController: gasController)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('পানি'),
            ),
            Expanded(
                child:
                    StepperTextField(textEditingController: waterController)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
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
