import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
import 'package:sweet_home/mvvm/views/owner_home/selected_home_info_page/home_info_page.dart';
import 'package:sweet_home/mvvm/views/owner_home/owner_home_list_page.dart';
import '../empty_pages/empty_home_page.dart';
import '../error_pages/error_page.dart';
import '../waiting_pages/circular_indicator_waiting.dart';

class OwnerHome extends StatelessWidget {
  const OwnerHome({super.key});

  @override
  Widget build(BuildContext context) {
    // AppWidget.taka;
    final provider = Provider.of<HomeListViewModel>(context);
    if (provider.isLoading) {
      return const CircularIndicator();
    }
    if (provider.status == Status.error) return const ErrorPage();
    if (provider.homeList.isEmpty) return const EmptyHomePage();
    return provider.homeList.length > 1
        ? OwnerHomeListPage(userHomes: provider.homeList)
        : HomeInfoPage(home: provider.homeList.first);
  }
}
