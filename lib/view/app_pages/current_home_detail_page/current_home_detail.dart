import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/view/resources/app_icons.dart';

import '../../../models/home_model.dart';
import '../../../models/home_summary.dart';
import '../../../services/database_service/home_crud.dart';
import '../../../utils/routes.dart';
import '../empty_page/empty_home_page.dart';
import 'components/home_detail_content.dart';

class CurrentHomeDetail extends StatefulWidget {
  CurrentHomeDetail({super.key});
  @override
  State<CurrentHomeDetail> createState() => _UserHomeDetailState();
}

class _UserHomeDetailState extends State<CurrentHomeDetail> {
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
          if (providerWatch.currentHomeId == null) {
            providerRead.setCurrentHomeName = homes.first.homeName;
            providerRead
                .updateHomeId(homes.first.homeId); //TODO : should be deleted
            providerRead.setCurrentHome(homes.first);
            // HomeDetailContent(home: homes.first);
          }
          return HomeDetailContent();
        });
  }

  Widget builda(BuildContext context) {
    final providerWatch = context.watch<CurrentHomeProvider>();
    CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();
    return StreamBuilder<List<HomeSummary>?>(
      stream: HomeCrud().getHome(),
      builder: (context, AsyncSnapshot<List<HomeSummary>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return showWaitingIndicator(context);
        }
        if (!snapshot.hasData) {}
        List<HomeSummary>? homes = snapshot.data;
        if (homes == null) return const EmptyHomePage();
        if (homes.isEmpty) return const EmptyHomePage();
        if (providerWatch.currentHomeId == null) {
          providerRead.setCurrentHomeName = homes.first.homeName!;
          providerRead.updateHomeId(homes.first.homeId);
          // HomeDetailContent(home: homes.first);
        }
        return HomeDetailContent();
      },
    );
  }

  Widget showWaitingIndicator(context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}
