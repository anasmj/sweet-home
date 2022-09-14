import 'package:flutter/material.dart';
import 'package:sweet_home/providers/profile.dart';
import 'package:sweet_home/services/auth_service.dart';
import 'package:sweet_home/view/authenticate_pages/authenticate.dart';
import '../models/app_user.dart';
import 'app_pages/home_page/app_home_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: AuthService().appUserStream,
      builder: (context, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final AppUser? appUser = snapshot.data;
          if (appUser == null) {
            return const Authenticate();
          } else {
            //set current user info in profile class
            Profile.email = appUser.userEmail;
            Profile.userId = appUser.userId;
            Profile.userName = appUser.userName;
            return const AppHomePage();
          }
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
