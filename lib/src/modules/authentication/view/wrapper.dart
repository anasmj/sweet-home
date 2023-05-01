import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/model/app.user.dart';
import 'package:sweet_home/src/modules/app.home/app_home_page.dart';
import 'package:sweet_home/src/modules/authentication/provider/auth.notifier.dart';

import '../compontents/authenticate.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: StreamBuilder<AppUser?>(
        stream: ref.read(appUserNotifier),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Loading..'),
            );
          }
          final AppUser? appUser = snapshot.data;
          if (appUser == null) {
            return const Authenticate();
          } else {
            // return HomePage();
            return const AppHomePage();
          }
        },
      ),
    );
  }
}
