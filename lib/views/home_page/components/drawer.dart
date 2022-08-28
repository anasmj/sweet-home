import 'package:flutter/material.dart';
import 'package:sweet_home/services/auth_service.dart';
import 'package:sweet_home/views/app_widgets.dart';
import 'package:sweet_home/views/steppers/add_home_stepper/add_home_stepper.dart';

import '../../../controllers/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  final String _logOut = "লগ আউট";
  final String _newAccount = "নতুন একাউন্ট";

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          color: Theme.of(context).primaryColor,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        child: FlutterLogo(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('নাজিম নূর', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('najimnour@gmail.com'),
                  const Spacer(),
                  optionsButton(context: context),
                ],
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () => AppWidget.showToast('প্রোফাইলের কাজ চলছে'),
          leading: const Icon(Icons.account_circle),
          title: const Text('প্রোফাইল'),
        ),
        ListTile(
          onTap: () => AppWidget.showToast('সেটিংসের কাজ চলছে'),
          leading: const Icon(Icons.settings),
          title: const Text('সেটিংস'),
        ),
        ListTile(
          onTap: () => AppRoute.newHomeStepper(context: context),
          leading: const Icon(Icons.home_filled),
          title: const Text('বাড়ী যোগ করুন'),
        ),
        const Spacer(),
        const ListTile(
          leading: FlutterLogo(),
          title: Text('build with flutter 3.3.0 '),
        ),
      ],
    ));
  }

  PopupMenuButton<String> optionsButton({required BuildContext context}) {
    return PopupMenuButton<String>(
      // icon: Icon(Icons.expand_more),

      tooltip: 'মেন্যু',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: _logOut,
          child: ListTile(
            title: Text(
              _logOut,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: const Icon(Icons.logout),
          ),
        ),
        PopupMenuItem(
          value: _logOut,
          child: ListTile(
            title: Text(
              _newAccount,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: const Icon(Icons.add),
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'লগ আউট':
            AuthService().signOut();
            // AppWidget.showToast('কাজ চলছে');
            break; //_showModalSheet()
          case 'নতুন একাউন্ট':
            AppWidget.showToast('কাজ চলছে');
            break; //_showModalSheet()
        }
      },
    );
  }
}
