import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweet_home/providers/profile.dart';
import 'package:sweet_home/services/auth_service.dart';
import 'package:sweet_home/views/shared_widgets.dart';
import '../../../controllers/routes.dart';
import 'change_theme_button.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  final String _otherAccounts = "অন্যান্য একাউন্ট";
  final String _newAccount = "একাউন্ট খুলুন";
  final TextStyle drawerTextStyle = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 300,
        elevation: 3.0,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              color: Theme.of(context).primaryColor,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            child: FlutterLogo(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //show name here
                          Text(
                            Profile.userName ?? 'Name not found',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      //show email
                      Text(
                        Profile.email ?? 'no email',
                      ),
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
              title: Text(
                'প্রোফাইল',
                style: drawerTextStyle,
              ),
            ),
            ListTile(
              onTap: () => AppWidget.showToast('সেটিংসের কাজ চলছে'),
              leading: const Icon(Icons.settings),
              title: Text(
                'সেটিংস',
                style: drawerTextStyle,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(
                'ডার্ক মোড',
                style: drawerTextStyle,
              ),
              trailing: const ChangeThemeButton(),
            ),
            ListTile(
              onTap: () => AppRoute.newHomeStepper(context: context),
              leading: const Icon(Icons.home_filled),
              title: Text(
                'বাড়ী যোগ করুন',
                style: drawerTextStyle,
              ),
            ),
            const Spacer(),
            ListTile(
              onTap: () => AuthService().signOut(),
              leading: const Icon(
                Icons.logout_outlined,
              ),
              title: Text(
                'লগ আউট ',
                style: drawerTextStyle,
              ),
            ),
            const ListTile(
              leading: FlutterLogo(),
              title: Text(
                'built with flutter 3.3.0 ',
                style: TextStyle(),
              ),
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
          value: _otherAccounts,
          child: const Text(
            "অন্যান্য একাউন্ট",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        PopupMenuItem(
          value: _newAccount,
          child: const ListTile(
            title: Text(
              "একাউন্ট খুলুন",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: Icon(Icons.add),
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'অন্যান্য একাউন্ট':

            // AppWidget.showToast('কাজ চলছে');
            break; //_showModalSheet()
          case 'একাউন্ট খুলুন':
            AppWidget.showToast('কাজ চলছে');
            break; //_showModalSheet()
        }
      },
    );
  }
}