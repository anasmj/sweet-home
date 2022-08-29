import 'package:flutter/material.dart';
import 'package:sweet_home/providers/current_user_provider.dart';
import 'package:sweet_home/services/auth_service.dart';
import 'package:sweet_home/views/authenticate/authenticate.dart';
import 'package:sweet_home/views/home_page/home_page.dart';
import '../models/app_user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: AuthService().appUserStream,
      builder: (context, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final AppUser? appUser = snapshot.data;
          if (appUser != null) {
            //set current user info in profile class
            Profile.email = appUser.userEmail;
            Profile.userId = appUser.userId;
          }
          return appUser == null ? const Authenticate() : const HomePage();
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
