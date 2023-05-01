import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/home.dart';

final selectedHomeNotifier =
    NotifierProvider<SelectedHomeProvider, Home?>(SelectedHomeProvider.new);

class SelectedHomeProvider extends Notifier<Home?> {
  @override
  Home? build() {
    return null;
  }

  void setHome(Home? home) {
    state = home;
  }
}
