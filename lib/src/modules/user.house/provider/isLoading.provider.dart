import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingNotifier = NotifierProvider<IsLoadingProvider, bool>(
  IsLoadingProvider.new,
);

class IsLoadingProvider extends Notifier<bool> {
  @override
  bool build() => false;
  void toggleLoading() => state = !state;
}
