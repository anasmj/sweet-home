import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tecProvider = NotifierProviderFamily<TextControllerProvider,
    TextEditingController, String>(TextControllerProvider.new);

class TextControllerProvider
    extends FamilyNotifier<TextEditingController, String> {
  @override
  TextEditingController build(String arg) => TextEditingController();
}
