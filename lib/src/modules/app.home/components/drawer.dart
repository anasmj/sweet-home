import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/trasparent.loading/transparent.loading.dart';
import 'package:sweet_home/src/extensions/extensions.dart';
import 'package:sweet_home/src/modules/authentication/provider/auth.notifier.dart';

import '../../user.house/view/user.house.dart';
import 'drawer_header.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  final TextStyle drawerTextStyle = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context, ref) {
    return Drawer(
      width: 300,
      elevation: 3.0,
      child: Column(
        children: [
          const Drawerheader(),
          // drawerHeader(context),
          ListTile(
            onTap: () => context.push(const UserHome()),
            leading: const Icon(
              Icons.home,
              color: Colors.pinkAccent,
            ),
            title: Text(
              'আপনার বাড়ী',
              style: drawerTextStyle,
            ),
          ),
          ListTile(
            onTap: () async {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const OwnerProfilePage(),
              //     ));
            },
            leading: const Icon(
              Icons.account_circle,
              color: Colors.deepOrange,
            ),
            title: Text(
              'প্রোফাইল',
              style: drawerTextStyle,
            ),
          ),
          ListTile(
            // onTap: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) {
            //         return const SettingsPage();
            //       },
            //     )),
            leading: const Icon(
              Icons.settings,
              color: Colors.indigo,
            ),
            title: Text(
              'সেটিংস',
              style: drawerTextStyle,
            ),
          ),
          ListTile(
            // onTap: () => AppRoute.newHomeStepper(context: context),
            leading: const Icon(
              Icons.group,
              color: Colors.teal,
            ),
            title: Text(
              'সকল গ্রাহক',
              style: drawerTextStyle,
            ),
          ),
          const Spacer(),
          ListTile(
            onTap: () async {
              transparentLoadIndicator(context);
              await ref.read(appUserNotifier.notifier).onLogout();
              if (context.mounted) {
                Navigator.pop(context);
              }
              // ScaffoldMessenger
            },
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.blueGrey,
            ),
            title: Text(
              'লগ আউট ',
              style: drawerTextStyle,
            ),
          ),
          ListTile(
            leading: const FlutterLogo(),
            title: Text(
              'built with flutter 3.3.0 ',
              style: const TextStyle().copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
