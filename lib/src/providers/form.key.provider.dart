import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formKeyProvider =
    NotifierProviderFamily<FormKeyProvider, GlobalKey<FormState>, String>(
        FormKeyProvider.new);

class FormKeyProvider extends FamilyNotifier<GlobalKey<FormState>, String> {
  @override
  GlobalKey<FormState> build(String arg) => GlobalKey<FormState>();
}
