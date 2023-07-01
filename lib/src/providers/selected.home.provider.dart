import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/api/home.services.dart';

import '../model/home.dart';

final selectedHomeProvider =
    NotifierProvider<SelectedHomeProvider, Home?>(SelectedHomeProvider.new);

class SelectedHomeProvider extends Notifier<Home?> {
  @override
  Home? build() {
    return null;
  }

  void setHome(Home? home) async {
    state = home;
  }

  void searchAndSetUserHome() async {
    final userHomes = await HomeServices().getAllHomes();
    if (userHomes == null || userHomes.isEmpty) return;
    state = userHomes.first;
  }
}
