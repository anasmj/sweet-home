import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../mvvm/services/home_services.dart';
import '../../mvvm/models/home_model.dart';

import '../../mvvm/providers/current_home.dart';
import '../../mvvm/views/empty_pages/empty_home_page.dart';
import '../../mvvm/views/home_info_page/home_info_page.dart';
import '../view/screens/home_options_page.dart';

class UserHomes extends StatefulWidget {
  const UserHomes({super.key});
  @override
  State<UserHomes> createState() => _UserHomeDetailState();
}

class _UserHomeDetailState extends State<UserHomes> {
  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<CurrentHomeProvider>();
    CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();
    return FutureBuilder<List<Home>>(
      future: HomeCrud().getAllHome(),
      builder: (context, AsyncSnapshot<List<Home>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return showWaitingIndicator(context);
        }
        if (!snapshot.hasData) {}
        List<Home>? homes = snapshot.data;
        if (homes == null) return const EmptyHomePage();
        if (homes.isEmpty) return const EmptyHomePage();
        Home? selectedHome = providerWatch.currentHome;
        if (selectedHome == null) {
          providerRead.setCurrentHome = homes.first;
        }
        return homes.length > 1
            ? HomeOptionsPage(userHomes: homes)
            : HomeInfoPage(
                home: homes.first,
              );
      },
    );
  }

  Widget showWaitingIndicator(context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}
