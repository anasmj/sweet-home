import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/app.widgets/app.widgets.dart';
import 'package:sweet_home/src/model/flat.dart';

import '../components/flat.container.components.dart';

final selectedFlatProvider =
    NotifierProvider<SelectedFlatProvider, Flat?>(SelectedFlatProvider.new);

class SelectedFlatProvider extends Notifier<Flat?> {
  @override
  Flat? build() => null;
  set(Flat flat) => state = flat;

  void onLongPress(BuildContext context, {required Flat flat}) {
    state = flat;

    AppWidget.getModalSheet(
        context: context, modalSheetContent: const FlatOptions());
  }
}
