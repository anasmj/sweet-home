import 'package:flutter/material.dart';
import 'package:sweet_home/services/auth_service.dart';
import 'package:sweet_home/views/authenticate/authenticate.dart';
import 'package:sweet_home/views/home_page/home_page.dart';
import '../models/app_user.dart';
import 'dismiss_keyboard.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // final userStream = Provider.of<AuthService>(context).appUserStream;
    return StreamBuilder<AppUser?>(
      stream: AuthService().appUserStream,
      builder: (context, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final AppUser? appUser = snapshot.data;
          return appUser == null
              ? Authenticate()
              : const DismissKeyboard(child: HomePage());
        } else {
          //trying to fetch data
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
