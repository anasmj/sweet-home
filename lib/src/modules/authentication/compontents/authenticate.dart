
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/authentication/compontents/login.page/login.page.dart';
import 'package:sweet_home/src/modules/authentication/compontents/registration.page/registration.page.dart';
import '../provider/login.notifier.dart';

class Authenticate extends ConsumerWidget {
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context, ref) {
    bool login = ref.watch(loginNotifier);
    return login ? const LoginPage() :  const RegistrationPage();
  }
}
