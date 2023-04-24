import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/empty.pages/empty.home.page/empty.home.page.dart';
import 'package:sweet_home/src/components/error.page/error_page.dart';
import 'package:sweet_home/src/providers/user.homes.provider.dart';

import '../component/user.home.info.dart';

class UserHome extends ConsumerWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // AppWidget.taka;
    return ref.watch(homesProvider).when(
      data: (homes) {
        if (homes == null) return const EmptyHomePage();
        if (homes.isEmpty) {
          return const EmptyHomePage();
        } else if (homes.length > 1) {
          // OwnerHomeListPage();
          return Container();
        } else {
          return HomeInfoPage(
            home: homes.first,
          );
        }
      },
      error: (e, t) {
        return const ErrorPage();
      },
      loading: () {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );

    // if (provider.isLoading) {
    //   return const CircularIndicator();
    // }
    // if (provider.status == Status.error) return const ErrorPage();
    // if (provider.homeList.isEmpty) return const EmptyHomePage();
    // return provider.homeList.length > 1
    //     ? OwnerHomeListPage(userHomes: provider.homeList)
    //     : HomeInfoPage(home: provider.homeList.first);
  }
}
