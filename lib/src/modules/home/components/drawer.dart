import 'package:flutter/material.dart';
import 'package:sweet_home/src/extensions/extensions.dart';
import 'drawer_header.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  final TextStyle drawerTextStyle = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    print(now.formatted());
    return Drawer(
      width: 300,
      elevation: 3.0,
      child: Column(
        children: [
          const Drawerheader(),
          // drawerHeader(context),
          ListTile(
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (BuildContext context) {
              //   return const OwnerHome();
              // }));
            },
            // onTap: () => AppRoute.toCurrentHomeDetail(context),
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
            onTap: () {
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
              // Response res = await AuthService().signOut();
              // if (res.code == 200) {
              // ignore: use_build_context_synchronously
              // context.read<CurrentHomeProvider>().setCurrentHome = null;
              // }
            },
            // onTap: () => AuthService().signOut(),
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
