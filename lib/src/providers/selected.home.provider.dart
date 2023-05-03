import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/api/home.services.dart';
import 'package:sweet_home/src/providers/user.homes.provider.dart';
import '../model/home.dart';

final selectedHomeNotifier =
    NotifierProvider<SelectedHomeProvider, Home?>(SelectedHomeProvider.new);

class SelectedHomeProvider extends Notifier<Home?> {
  @override
  Home? build() {
    return null;
  }

  void setHome(Home? home) async {
    // if (home == null) {
    //   final homes = ref.read(homesProvider);
    // }
    state = home;
  }

  void searchAndSetUserHome() async {
    final userHomes = await HomeServices().getAllHomes();
    if (userHomes!.isEmpty) return;
    state = userHomes.first;
  }
}
