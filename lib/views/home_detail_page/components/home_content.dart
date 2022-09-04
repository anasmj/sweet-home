import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/views/home_detail_page/components/stepper_textfield.dart';

import '../../../models/home_model.dart';
import '../../styling/app_icons.dart';

TextEditingController nameController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController gasControllre = TextEditingController();
TextEditingController waterConteroller = TextEditingController();

class HomeContent extends StatelessWidget {
  HomeContent({
    Key? key,
    required this.home,
  }) : super(key: key);

  final Home home;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(home.homeName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            ListTile(
              onTap: () => showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  context: context,
                  // isScrollControlled: true,
                  builder: (context) {
                    return Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                          child: divider(isDarkMode),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: AppTextField(
                            textEditingController: controller,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {},
                          child: const Text('আপডেট',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    );
                  }),
              leading: const Icon(
                Icons.home_filled,
              ),
              title: const Text('নাম'),
              subtitle: Text(home.homeName),
            ),
            ListTile(
              leading: Image.asset(
                AppIcons.takaUrl,
                height: 20,
                color: Colors.grey.shade600,
              ),
              title: const Text('ভাড়া'),
              subtitle: const Text(
                '34231',
              ),
            ),
            const ListTile(
              leading: Icon(Icons.map),
              title: Text('ঠিকানা'),
              subtitle: Text(
                'লালামটিয়া',
              ),
            ),
            const ListTile(
              leading: Icon(Icons.format_list_numbered_rounded),
              title: Text('তলা'),
              subtitle: Text(
                '4',
              ),
            ),
            const ListTile(
              leading: Icon(Icons.view_column),
              title: Text('ফ্ল্যাট সংখ্যা'),
              subtitle: Text(
                '2',
              ),
            ),
            const ListTile(
              leading: Icon(Icons.gas_meter_outlined),
              title: Text('গ্যাস'),
              subtitle: Text(
                '2',
              ),
            ),
            const ListTile(
              leading: Icon(Icons.water_drop_outlined),
              title: Text('পানি'),
              subtitle: Text(
                '2',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container divider(bool isDarkMode) {
    return Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: isDarkMode ? Colors.white60 : Colors.grey.shade700,
      ),
      height: 4,
      width: 20,
    );
  }
}
