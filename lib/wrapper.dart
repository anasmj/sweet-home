import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'prev/models/app_user.dart';
import 'mvvm/models/profile.dart';
import 'mvvm/services/auth_service.dart';
import 'mvvm/views/authenticate_pages/authenticate.dart';

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
