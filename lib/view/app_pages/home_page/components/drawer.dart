import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/providers/new_home_step_provider.dart';
import 'package:sweet_home/providers/profile.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/services/auth_service.dart';
import 'package:sweet_home/services/flat_services.dart';
import 'package:sweet_home/utils/user_flat.dart';
import 'package:sweet_home/view/app_widgets.dart';
import '../../../../models/flat_model.dart';
import '../../../../models/home_model.dart';
import '../../../../models/renter.dart';
import '../../../../services/home_services.dart';
import '../../../../utils/routes.dart';
import 'change_theme_button.dart';
import 'homes_popup.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  final String _otherAccounts = "অন্যান্য একাউন্ট";
  final String _newAccount = "একাউন্ট খুলুন";
  final TextStyle drawerTextStyle = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    Home? home = context.watch<CurrentHomeProvider>().currentHome;
    bool isDark = context.watch<ThemeProvider>().isDarkMode;
    NewHomeStepProvider newHome = context.watch<NewHomeStepProvider>();
    return Drawer(
      width: 300,
      elevation: 3.0,
      child: Column(
        children: [
          drawerHeader(context),
          ListTile(
            onTap: () => AppRoute.toCurrentHomeDetail(context),
            leading: const Icon(Icons.home),
            title: Text(
              'আপনার বাড়ী',
              style: drawerTextStyle,
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
          ListTile(
            onTap: () async {
              if (home == null) print('home is null found_drawer');
              if (home != null) {
                // CollectionReference flatsCollectionRef =
                //     await FlatService().getFlatsCollectionRef(home.homeId);
                // final flatsSnapshot = await flatsCollectionRef.get();

                // flatsSnapshot.docs.map((flat) {
                //   try {
                //     var renterData = flat['renter'] as Map<String, dynamic>;
                //     if (renterData.isNotEmpty) {
                //       Renter? renter = Renter.fromJson(renterData);
                //     }
                //   } catch (e) {}
                // }).toList();
              }
            },
            leading: const Icon(Icons.edit),
            title: Text(
              'test',
              style: drawerTextStyle,
            ),
          ),
          const Spacer(),
          ListTile(
            onTap: () {
              AuthService().signOut();
              context.read<CurrentHomeProvider>().setCurrentHome(null);
            },
            // onTap: () => AuthService().signOut(),
            leading: const Icon(
              Icons.logout_outlined,
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

  Container drawerHeader(BuildContext context) {
    // context.read<CurrentHomeProvider>().setCurrentHomeName = null;
    CurrentHomeProvider watchProvider = context.watch<CurrentHomeProvider>();

    const double withAndHeight = 8;
    const double containerHeight = 200;
    bool isDark = context.read<ThemeProvider>().isDarkMode;
    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.grey.shade900, Colors.grey.shade900]
              : [Colors.blue.shade400, Colors.blue.shade800],
        ),
      ),
      height: containerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              watchProvider.currentHome != null
                  ? watchProvider.currentHome!.homeName
                  : '',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          // const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getNameAndEmail(),

                //TODO: to fix alignment problem
                FutureBuilder<List<Home>>(
                  future: HomeCrud().getAllHome(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                      // return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) return const Text('error Occured');
                    List<Home> userHomes = snapshot.data;
                    if (userHomes.isNotEmpty) {
                      return HomesPopupButton(
                        userHomes: userHomes,
                        onHomeDelete: () => closeDrawer(drawerContext: context),
                      );
                    }
                    //show nothing if user have no home
                    return const SizedBox();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void closeDrawer({required BuildContext drawerContext}) {
    Navigator.pop(drawerContext);
  }

  SizedBox getNameAndEmail() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Profile.userName ?? 'Name not found',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            Profile.email ?? 'no email',
          ),
        ],
      ),
    );
  }
}
