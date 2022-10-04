import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/views/init_home.dart';
import 'package:sweet_home/prev/models/home_model.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';

import 'mvvm/views/app_home_page/app_home_page.dart';
import 'prev/models/app_user.dart';
import 'prev/providers/profile.dart';
import 'prev/services/auth_service.dart';
import 'prev/view/authenticate_pages/authenticate.dart';

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
            return Provider.of<CurrentHomeProvider>(context).displayWidget;
            // return const AppHomePage();
          }
        } else {
          //trying to fetch data
          return const Scaffold(
            body: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
