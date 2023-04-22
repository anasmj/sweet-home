import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/model/home_model.dart';
import 'package:sweet_home/src/services/home.services.dart';

final userHomesProvider = AsyncNotifierProvider<UserHomesProvider, List<Home>?>(
  UserHomesProvider.new,
);

class UserHomesProvider extends AsyncNotifier<List<Home>?> {
  @override
  Future<List<Home>?> build() async {
    return await HomeServices().getAllHomes();
  }
}