import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/current_home.dart';
import '../models/home_model.dart';
import '../services/home_services.dart';
import '../view/app_pages/empty_home_page.dart';
import '../view/app_pages/home_detail_page/home_detail_page.dart';
import '../view/app_pages/home_options_page.dart';

class UserHomes extends StatefulWidget {
  UserHomes({super.key});
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
        Home? selectedHome = providerWatch.getCurrentHome;
        if (selectedHome == null) {
          providerRead.setCurrentHome(homes.first);
        }
        return homes.length > 1
            ? HomeOptionsPage(userHomes: homes)
            : HomeDetail(
                home: homes.first,
              );
      },
    );
  }

  Widget showWaitingIndicator(context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}
