import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/api/home.services.dart';
import 'package:sweet_home/src/model/home.dart';

import '../../user.house/provider/isLoading.provider.dart';

final newHomeProvider =
    NotifierProvider<NewHomeProvider, Home>(NewHomeProvider.new);

class NewHomeProvider extends Notifier<Home> {
  bool isCompleted = false;
  bool isLoading = false;
  @override
  Home build() {
    return Home(
      homeName: '',
      flatPerFloor: 1,
      floor: 1,
      rentAmount: 2000,
      location: '',
    );
  }

  Future<bool> onAddHome() async {
    // final res = await HomeServices().addHome(home: state);
    ref.read(isLoadingNotifier.notifier).toggleLoading();
    final res = await HomeServices().addHome(home: state);

    ref.invalidate(newHomeProvider);
    ref.read(isLoadingNotifier.notifier).toggleLoading();
    return res.code == 200;
  }

  void onHomeNameChange(String s) {
    state.homeName = s;
  }

  void onHomeAddressChange(String s) {
    state.location = s;
  }

  void onGasChange(String s) {
    state.gasBill = int.parse(s);
  }

  void onWaterChange(String s) {
    state.waterBill = int.parse(s);
  }

  void addFloor() {
    state = state.copyWith(floor: state.floor! + 1);
  }

  void deleteFloor() {
    if (state.floor == 1) return;
    state = state.copyWith(floor: state.floor! - 1);
  }

  void addFlat() {
    state = state.copyWith(flatPerFloor: state.flatPerFloor! + 1);
  }

  void deleteFlat() {
    if (state.flatPerFloor == 1) return;
    state = state.copyWith(flatPerFloor: state.flatPerFloor! - 1);
  }
}
