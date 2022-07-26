import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/views/app_home_page/components/drawer_header.dart';
import 'package:sweet_home/mvvm/views/owner_home/owner_home.dart';
import '../../../providers/current_home.dart';
import '../../../services/auth_service.dart';
import '../../../../prev/utils/routes.dart';
import '../../profile_pages/owner_profile_page.dart';
import '../../setting_page/setting_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  final TextStyle drawerTextStyle = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      elevation: 3.0,
      child: Column(
        children: [
          const Drawerheader(),
          // drawerHeader(context),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const OwnerHome();
              }));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OwnerProfilePage(),
                  ));
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
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                )),
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
            onTap: () => AppRoute.newHomeStepper(context: context),
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
              Response res = await AuthService().signOut();
              if (res.code == 200) {
                // ignore: use_build_context_synchronously
                context.read<CurrentHomeProvider>().setCurrentHome = null;
              }
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

  //*seperated into DrawerHeader class. delete if no proble found later
  // Container drawerHeader(BuildContext context) {
  //   // context.read<CurrentHomeProvider>().setCurrentHomeName = null;
  //   CurrentHomeProvider watchProvider = context.watch<CurrentHomeProvider>();

  //   const double withAndHeight = 8;
  //   const double containerHeight = 200;
  //   bool isDark = context.read<ThemeProvider>().isDarkMode;
  //   return Container(
  //     padding: const EdgeInsets.only(left: 20),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: isDark
  //             ? [Colors.grey.shade900, Colors.grey.shade900]
  //             : [Colors.blue.shade400, Colors.blue.shade800],
  //       ),
  //     ),
  //     height: containerHeight,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(top: 30.0),
  //           child: Text(
  //             watchProvider.currentHome != null
  //                 ? watchProvider.currentHome!.homeName
  //                 : '',
  //             style: Theme.of(context).textTheme.titleLarge,
  //           ),
  //         ),
  //         // const Spacer(),
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 10),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               getNameAndEmail(),

  //               FutureBuilder<List<Home>>(
  //                 future: HomeServices().getAllHome(),
  //                 builder: (context, AsyncSnapshot snapshot) {
  //                   if (!snapshot.hasData) {
  //                     return const SizedBox();
  //                     // return const CircularProgressIndicator();
  //                   }
  //                   if (snapshot.hasError) return const Text('error Occured');
  //                   List<Home> userHomes = snapshot.data;
  //                   if (userHomes.isNotEmpty) {
  //                     return HomesPopupButton(
  //                       userHomes: userHomes,
  //                       onHomeDelete: () => closeDrawer(drawerContext: context),
  //                     );
  //                   }
  //                   //show nothing if user have no home
  //                   return const SizedBox();
  //                 },
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // void closeDrawer({required BuildContext drawerContext}) {
  //   Navigator.pop(drawerContext);
  // }

  // SizedBox getNameAndEmail() {
  //   return SizedBox(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           Profile.userName ?? 'Name not found',
  //           style: const TextStyle(fontSize: 18),
  //         ),
  //         Text(
  //           Profile.email ?? 'no email',
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
