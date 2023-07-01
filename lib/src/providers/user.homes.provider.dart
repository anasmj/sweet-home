import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/api/home.services.dart';
import 'package:sweet_home/src/model/home.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart';

final homesProvider = AsyncNotifierProvider<UserHomesProvider, List<Home>?>(
  UserHomesProvider.new,
);

class UserHomesProvider extends AsyncNotifier<List<Home>?> {
  @override
  Future<List<Home>?> build() async {
    List<Home>? userHomes = await HomeServices().getAllHomes();
    if (userHomes!.isNotEmpty) {
      ref.read(selectedHomeProvider.notifier).setHome(userHomes.first);
    }

    return await HomeServices().getAllHomes();
  }
}
