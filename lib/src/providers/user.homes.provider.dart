import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/model/home.dart';
import 'package:sweet_home/src/api/home.services.dart';

final homesProvider = AsyncNotifierProvider<UserHomesProvider, List<Home>?>(
  UserHomesProvider.new,
);

class UserHomesProvider extends AsyncNotifier<List<Home>?> {
  @override
  Future<List<Home>?> build() async {
    return await HomeServices().getAllHomes();
  }
}
