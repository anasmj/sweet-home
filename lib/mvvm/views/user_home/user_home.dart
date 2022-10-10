import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/view_models/home_view_model.dart';
import 'package:sweet_home/mvvm/views/home_info_page/home_info_page.dart';
import 'package:sweet_home/prev/view/screens/home_options_page.dart';

import '../../models/home_model.dart';
import '../empty_pages/empty_home_page.dart';

class UsesrHome extends StatelessWidget {
  const UsesrHome({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();
    final providerWatch = context.watch<CurrentHomeProvider>();
    final provider = Provider.of<HomeListViewModel>(context, listen: false);

    List<Home> homeList = provider.homeList;

    // if (provider.status == Status.loading) {
    //   return showWaitingIndicator(context);
    // }
    // if (provider.status == Status.error) return Text('error detected');
    // if (provider.status == Status.empty) return const EmptyHomePage();

    // if (provider.status == Status.completed) {
    //   Home? selectedHome = providerWatch.currentHome;

    //   if (selectedHome == null) {
    //     providerRead.setCurrentHome = provider.homeList.first;
    //   }
    //   return provider.homeList.length > 1
    //       ? HomeOptionsPage(userHomes: provider.homeList)
    //       : HomeInfoPage(
    //           home: provider.homeList.first,
    //         );
    // }
    return Scaffold();
  }

  Widget showWaitingIndicator(context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}
