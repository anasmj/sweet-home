import 'package:flutter/material.dart';
import 'package:sweet_home/views/authenticate/registration_page.dart';
import 'package:sweet_home/views/authenticate/login_page.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) => showSignIn
      ? LoginPage(toggleView: toggleView)
      : RegistrationPage(toggleView: toggleView);
}
