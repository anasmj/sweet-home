import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/components/app.widgets/app.widgets.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/modules/flats/components/flat.container/flat.container.components.dart';

final selectedFlatNotifier =
    NotifierProvider<SelectedFlatProvider, Flat?>(SelectedFlatProvider.new);

class SelectedFlatProvider extends Notifier<Flat?> {
  @override
  Flat? build() => null;

  void onSelect(BuildContext context, {required Flat flat}) {
    //  flat.renter == null ? addRenter(context) : openRenterPage(context);
  }

  void onLongPress(BuildContext context, {required Flat flat}) {
    state = flat;

    AppWidget.getModalSheet(
        context: context, modalSheetContent: const FlatOptions());
  }
}
